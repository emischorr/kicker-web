defmodule KickerWeb.DashboardController do
  use KickerWeb.Web, :controller

  alias KickerWeb.Repo
  alias KickerWeb.Player

  # plug :put_layout, "minimal.html"

  def index(conn, _params) do
    top_players = Repo.all(Player)
    render conn, "index.html", top_players: top_players
  end

  def live(conn, _params) do
    render conn, "live.html", layout: {KickerWeb.LayoutView, "minimal.html"}
  end

  def start(conn, _params) do
    IO.inspect KickerWeb.Redis.command(~w(PUBLISH event.start 1))
    # conn
    # |> put_status(:created)
    # |> render("match.json", session: session, player: player)
    json conn, "test"
  end
end
