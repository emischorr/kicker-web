defmodule KickerWeb.API.TableView do
  use KickerWeb.Web, :view

  def render("index.json", %{tables: tables}) do
    %{data: render_many(tables, KickerWeb.API.TableView, "table.json")}
  end

  def render("show.json", %{table: table}) do
    %{data: render_one(table, KickerWeb.API.TableView, "table.json")}
  end

  def render("table.json", %{table: table}) do
    %{id: table.id,
      name: table.name}
  end
end
