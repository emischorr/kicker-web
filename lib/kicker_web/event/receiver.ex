defmodule KickerWeb.Event.Receiver do
  use GenServer
  require Logger

  alias KickerWeb.Repo
  alias KickerWeb.Ruleset

  @process_name :event_receiver
  @redis_sub_channel "event.*"

  def start_link do
    GenServer.start_link(__MODULE__, [], name: @process_name)
  end

  def init(_opts) do
    {:ok, %{pub_sub_con: nil}, 0}
  end

  def handle_info(:timeout, _state) do
    # timeout of 0 on init on purpose to defer the redis queue subscribe to here
    {:ok, pub_sub_conn} = Redix.PubSub.start_link
    :ok = Redix.PubSub.psubscribe(pub_sub_conn, @redis_sub_channel, self())

    {:noreply, %{pub_sub_conn: pub_sub_conn}}
  end

  def handle_info({:redix_pubsub, _pid, :psubscribed, _topic}, state) do
    {:noreply, state}
  end

  def handle_info({:redix_pubsub, _pid, :pmessage, message}, state) do
    "event."<>event = message.channel
    IO.puts "Handling Event <#{event}>: #{inspect message.payload}"
    case event do
      "start" ->
        Ruleset
        |> Repo.get(message.payload)
        |> KickerWeb.MatchServer.start_match
      "goal" ->
        KickerWeb.MatchServer.goal(message.payload)
      "revoke" ->
        KickerWeb.MatchServer.revoke_goal(message.payload)
      x ->
        Logger.warn "Unknown event: #{x}"
    end

    {:noreply, state}
  end

end
