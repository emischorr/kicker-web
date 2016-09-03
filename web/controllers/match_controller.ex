defmodule KickerWeb.MatchController do
  use KickerWeb.Web, :controller

  alias KickerWeb.Repo
  alias KickerWeb.Match
  alias KickerWeb.Player

  def index(conn, _params) do
    matches = Repo.all(Match)
    render(conn, "index.html", matches: matches)
  end

  def show(conn, %{"id" => id} = params) do
    match = Repo.get(Match, id)
    render(conn, "show.html", match: match)
  end

  def new(conn, _params) do
    changeset = Match.changeset(%Match{})
    players = Repo.all(Player)
    render(conn, "new.html", changeset: changeset, players: players)
  end

  def create(conn, %{"match" => match_params}) do
    changeset = Match.changeset(%Match{}, match_params)

    case Repo.insert(changeset) do
      {:ok, _match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: match_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
