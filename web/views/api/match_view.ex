defmodule KickerWeb.API.MatchView do
  use KickerWeb.Web, :view

  def render("index.json", %{matches: matches}) do
    %{data: render_many(matches, KickerWeb.API.MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{data: render_one(match, KickerWeb.API.MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{id: match.id,
      goals_team1: match.goals_team1,
      goals_team2: match.goals_team2}
  end
end
