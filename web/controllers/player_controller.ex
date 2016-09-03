defmodule KickerWeb.PlayerController do
  use KickerWeb.Web, :controller

  alias KickerWeb.Player
  alias KickerWeb.Statistics

  plug :scrub_params, "player" when action in [:create, :update]

  def index(conn, _params) do
    players = Repo.all(Player)
    render(conn, "index.html", players: players)
  end

  def show(conn, %{"id" => id} = params) do
    player = Repo.get(Player, id)
    player_statistics = Statistics.player_statistics(id)
    render(conn, "show.html", player: player, player_statistics: player_statistics)
  end

  def profile(conn, _params) do
    player = current_player(conn)
    changeset = Player.changeset(player)
    render(conn, "edit.html", player: player, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Player.changeset(%Player{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"player" => player_params}) do
    changeset = Player.changeset(%Player{}, player_params)

    case Repo.insert(changeset) do
      {:ok, _player} ->
        conn
        |> put_flash(:info, "Player created successfully.")
        |> redirect(to: session_path(conn, :new))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"player" => player_params}) do
    player = current_player(conn)
    changeset = Player.changeset(player, player_params)

    case Repo.update(changeset) do
      {:ok, player} ->
        conn
        |> put_flash(:info, "Player updated successfully.")
        |> redirect(to: player_path(conn, :profile))
      {:error, changeset} ->
        render(conn, "edit.html", player: player, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    player = current_player(conn)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(player)

    conn
    |> put_flash(:info, "Player deleted successfully.")
    |> redirect(to: session_path(conn, :new))
  end

end
