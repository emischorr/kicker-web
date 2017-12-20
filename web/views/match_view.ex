defmodule KickerWeb.MatchView do
  use KickerWeb.Web, :view

  def result(match) do
    "#{match.goals_team1}:#{match.goals_team2}"
  end

  def team1(match) do
    "#{match.keeper_team1_id}, #{match.striker_team1_id}"
  end

  def team2(match) do
    "#{match.keeper_team2_id}, #{match.striker_team2_id}"
  end
end
