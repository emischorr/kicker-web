defmodule KickerWeb.MatchController do
  use KickerWeb.Web, :controller

  alias KickerWeb.Match

  def index(conn, _params) do
    matches = Repo.all(Match)
    render(conn, "index.html", matches: matches)
  end

  def show(conn, %{"id" => id} = params) do
    match = Repo.get(Match, id)
    render(conn, "show.html", match: match)
  end

end
