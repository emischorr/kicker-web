defmodule KickerWeb.Session do
  require Logger

  alias KickerWeb.Repo
  alias KickerWeb.Player

  # TODO: get only ID from session and get objects out of memory (ETS)
  def current_player(conn) do
    id = Plug.Conn.get_session(conn, :player_id)
    Repo.get(Player, id)
  end

  def logged_in?(conn) do
    # !!current_player(conn)
    !!Plug.Conn.get_session(conn, :player_id)
  end

end
