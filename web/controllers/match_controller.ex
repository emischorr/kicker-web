defmodule KickerWeb.MatchController do
  use KickerWeb.Web, :controller

  alias KickerWeb.Repo
  alias KickerWeb.Match
  alias KickerWeb.Player
  alias KickerWeb.Ruleset

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
    rulesets = Repo.all(Ruleset)
    render(conn, "new.html", changeset: changeset, players: players, rulesets: rulesets)
  end

  def create(conn, %{"match" => match_params}) do
    changeset = Match.changeset(%Match{}, match_params)

    case Repo.insert(changeset) do
      {:ok, _match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: match_path(conn, :index))
      {:error, changeset} ->
        players = Repo.all(Player)
        rulesets = Repo.all(Ruleset)
        render(conn, "new.html", changeset: changeset, players: players, rulesets: rulesets)
    end
  end

end
