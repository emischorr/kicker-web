defmodule KickerWeb.DashboardController do
  use KickerWeb.Web, :controller

  # plug :put_layout, "minimal.html"

  def index(conn, _params) do
    IO.inspect KickerWeb.Redis.command(~w(PUBLISH event.goal 1))
    render conn, "index.html"
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
