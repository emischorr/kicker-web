defmodule KickerWeb.Statistics.PlayerStatistics do
  defstruct matches: 0, won: 0, lost: 0, lost_with_no_goals: 0
end

defmodule KickerWeb.Statistics do
  alias KickerWeb.Repo
  alias KickerWeb.Match
  alias KickerWeb.Statistics.PlayerStatistics

  def player_statistics(player_id) do
    %PlayerStatistics{
      matches: matches(player_id),
      won: won(player_id),
      lost: lost(player_id),
      lost_with_no_goals: lost_with_no_goals(player_id)
    }
  end

  def matches(player_id, ruleset_id \\ 1) do
    Match
    |> Match.by_ruleset(ruleset_id)
    |> Match.for_player(player_id)
    |> Match.count
    |> Repo.one
  end

  def won(player_id, ruleset_id \\ 1) do
    Match
    |> Match.by_ruleset(ruleset_id)
    |> Match.player_won(player_id)
    |> Match.count
    |> Repo.one
  end

  def lost(player_id, ruleset_id \\ 1) do
    Match
    |> Match.by_ruleset(ruleset_id)
    |> Match.player_lost(player_id)
    |> Match.count
    |> Repo.one
  end

  def lost_with_no_goals(player_id, ruleset_id \\ 1) do
    Match
    |> Match.by_ruleset(ruleset_id)
    |> Match.player_lost(player_id)
    |> Match.zero_goals
    |> Match.count
    |> Repo.one
  end

end
