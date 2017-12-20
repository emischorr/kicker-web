defmodule KickerWeb.MatchServer do
  use GenServer
  require Logger

  # TODO: change to table name
  @process_name :match
  @init_state %{team1: 0, team2: 0, ruleset: %{}}

  ### public api
  def start_link do
    GenServer.start_link(__MODULE__, [], name: @process_name)
  end

  def start_match(ruleset) do
    Logger.debug "Start match"
    case Process.whereis(@process_name) do
      nil ->
        {:ok, pid} = start_link()
        Logger.debug "Started new match process: #{@process_name} [#{ruleset.name}]."
      _pid ->
        Logger.debug "Restart existing match [#{ruleset.name}]."
    end
    GenServer.call(@process_name, {:start_match, ruleset})
  end

  def goal(team) do
    try do
      GenServer.call(@process_name, {:goal, team})
    catch
      :exit, _ -> "match not yet started"
    end
  end

  def revoke_goal(team) do
    try do
      GenServer.call(@process_name, {:revoke_goal, team})
    catch
      :exit, _ -> "match not yet started"
    end
  end



  ### GenServer callbacks
  def init(_opts) do
    {:ok, @init_state}
  end

  def handle_call({:start_match, ruleset}, _from, state) do
    new_state = @init_state
    |> put_in([:ruleset], ruleset)
    |> broadcast_score
    {:reply, :ok, new_state}
  end

  def handle_call({:goal, team}, _from, state) do
    new_state = case team do
      "1" -> update_in state[:team1], &(&1+1)
      "2" -> update_in state[:team2], &(&1+1)
    end
    broadcast_score(new_state)
    {:reply, :ok, new_state}
  end

  def handle_call({:revoke_goal, team}, _from, state) do
    new_state = case team do
      "1" -> update_in state[:team1], &(&1-1)
      "2" -> update_in state[:team2], &(&1-1)
    end
    broadcast_score(new_state)
    {:reply, :ok, new_state}
  end

  # discard unknown messages
  def handle_info(msg, state) do
    Logger.debug "Unknown message: #{msg}"
    {:noreply, state}
  end



  defp broadcast_score(state) do
    case state do
      %{team1: goals1, team2: goals2, ruleset: %{goal_limit: goals1}} ->
        KickerWeb.Endpoint.broadcast("match:live", "end", Map.take(state, [:team1, :team2]))
      %{team1: goals1, team2: goals2, ruleset: %{goal_limit: goals2}} ->
        KickerWeb.Endpoint.broadcast("match:live", "end", Map.take(state, [:team1, :team2]))
      state ->
        KickerWeb.Endpoint.broadcast("match:live", "result", Map.take(state, [:team1, :team2]))
    end
  end

end
