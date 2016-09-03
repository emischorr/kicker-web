defmodule KickerWeb.SessionController do
  use KickerWeb.Web, :controller

  alias KickerWeb.Player

  def new(conn, _) do
    changeset = Player.changeset(%Player{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"player" => session}) do
    changeset = Player.changeset %Player{}, session
    if player = Player.authenticate?(changeset) do
      conn
        |> put_session(:player_id, player)
        |> redirect(to: dashboard_path(conn, :index))
    end
    render conn, "new.html", changeset: changeset
  end

  def delete(conn, _) do
    conn
      |> put_session(:player_id, nil)
      |> redirect(to: session_path(conn, :new))
  end

end
