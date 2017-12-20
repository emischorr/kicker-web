defmodule KickerWeb.MatchServer do
  use GenServer
  require Logger

  @process_name :match
  @init_state %{team1: 0, team2: 0}

  ### public api
  def start_link do
    GenServer.start_link(__MODULE__, [], name: @process_name)
  end

  def start_match do
    Logger.debug "Start match"
    case Process.whereis(@process_name) do
      nil ->
        {:ok, pid} = start_link()
        Logger.debug "Started new match process: #{@process_name}."
      _pid ->
        Logger.debug "Restart existing match."
    end
    GenServer.call(@process_name, :start_match)
  end

  def goal(team) do
    try do
      GenServer.call(@process_name, {:goal, team})
    catch
      :exit, _ -> "match not yet started"
    end
  end

  def remove_goal(team) do
    try do
      GenServer.call(@process_name, %{:revoke_goal, team})
    catch
      :exit, _ -> "match not yet started"
    end
  end



  ### GenServer callbacks
  def init(_opts) do
    {:ok, @init_state}
  end

  def handle_call(:start_match, _from, state) do
    broadcast_state(state)
    {:reply, :ok, @init_state}
  end

  def handle_call({:goal, team}, _from, state) do
    new_state = case team do
      "1" -> update_in state[:team1], &(&1+1)
      "2" -> update_in state[:team2], &(&1+1)
    end
    broadcast_state(new_state)
    {:reply, :ok, new_state}
  end

  def handle_call({:revoke_goal, team}, _from, state) do
    new_state = case team do
      "1" -> update_in state[:team1], &(&1-1)
      "2" -> update_in state[:team2], &(&1-1)
    end
    broadcast_state(new_state)
    {:reply, :ok, new_state}
  end

  # discard unknown messages
  def handle_info(msg, state) do
    Logger.debug "Unknown message: #{msg}"
    {:noreply, state}
  end



  defp broadcast_state(state) do
    KickerWeb.Endpoint.broadcast("match:live", "result", state)
  end

end
