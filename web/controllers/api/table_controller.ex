defmodule KickerWeb.API.TableController do
  use KickerWeb.Web, :controller

  alias KickerWeb.Table

  plug :scrub_params, "table" when action in [:create, :update]

  def index(conn, _params) do
    tables = Repo.all(Table)
    render(conn, "index.json", tables: tables)
  end

  def create(conn, %{"table" => table_params}) do
    changeset = Table.changeset(%Table{}, table_params)

    case Repo.insert(changeset) do
      {:ok, table} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", table_path(conn, :show, table))
        |> render("show.json", table: table)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KickerWeb.API.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    table = Repo.get!(Table, id)
    render(conn, "show.json", table: table)
  end

  def update(conn, %{"id" => id, "table" => table_params}) do
    table = Repo.get!(Table, id)
    changeset = Table.changeset(table, table_params)

    case Repo.update(changeset) do
      {:ok, table} ->
        render(conn, "show.json", table: table)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KickerWeb.API.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    table = Repo.get!(Table, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(table)

    send_resp(conn, :no_content, "")
  end
end
