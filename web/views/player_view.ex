defmodule KickerWeb.PlayerView do
  use KickerWeb.Web, :view

  def render("index.json", %{players: players}) do
    %{data: render_many(players, KickerWeb.PlayerView, "player.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, KickerWeb.PlayerView, "player.json")}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      name: player.name,
      email: player.email}
  end
end
