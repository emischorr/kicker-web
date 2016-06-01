defmodule KickerWeb.API.RulesetController do
  use KickerWeb.Web, :controller

  alias KickerWeb.Ruleset

  plug :scrub_params, "ruleset" when action in [:create, :update]

  def index(conn, _params) do
    rulesets = Repo.all(Ruleset)
    render(conn, "index.json", rulesets: rulesets)
  end

  def create(conn, %{"ruleset" => ruleset_params}) do
    changeset = Ruleset.changeset(%Ruleset{}, ruleset_params)

    case Repo.insert(changeset) do
      {:ok, ruleset} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ruleset_path(conn, :show, ruleset))
        |> render("show.json", ruleset: ruleset)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KickerWeb.API.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ruleset = Repo.get!(Ruleset, id)
    render(conn, "show.json", ruleset: ruleset)
  end

  def update(conn, %{"id" => id, "ruleset" => ruleset_params}) do
    ruleset = Repo.get!(Ruleset, id)
    changeset = Ruleset.changeset(ruleset, ruleset_params)

    case Repo.update(changeset) do
      {:ok, ruleset} ->
        render(conn, "show.json", ruleset: ruleset)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KickerWeb.API.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ruleset = Repo.get!(Ruleset, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(ruleset)

    send_resp(conn, :no_content, "")
  end
end
