defmodule KickerWeb.Match do
  use KickerWeb.Web, :model

  schema "matches" do
    field :goals_team1, :integer, default: 0
    field :goals_team2, :integer, default: 0

    belongs_to :ruleset, KickerWeb.Ruleset

    belongs_to :keeper_team1, KickerWeb.Player
    belongs_to :striker_team1, KickerWeb.Player
    belongs_to :keeper_team2, KickerWeb.Player
    belongs_to :striker_team2, KickerWeb.Player

    timestamps()
  end

  @required_fields ~w(goals_team1 goals_team2 ruleset_id)a
  @optional_fields ~w(keeper_team1_id striker_team1_id keeper_team2_id striker_team2_id)a

  def count(query) do
    from m in query,
    select: count(m.id)
  end

  def for_player(query, player_id) do
    from m in query,
    where: m.keeper_team1_id == ^player_id or m.striker_team1_id == ^player_id or m.keeper_team2_id == ^player_id or m.striker_team2_id == ^player_id
  end

  def player_in_team1(query, player_id) do
    from m in query,
    where: m.keeper_team1_id == ^player_id or m.striker_team1_id == ^player_id
  end

  def player_in_team2(query, player_id) do
    from m in query,
    where: m.keeper_team2_id == ^player_id or m.striker_team2_id == ^player_id
  end

  def player_lost(query, player_id) do
    from m in query,
    where: ((m.keeper_team1_id == ^player_id or m.striker_team1_id == ^player_id) and m.goals_team1 < m.goals_team2 ) or ((m.keeper_team2_id == ^player_id or m.striker_team2_id == ^player_id) and m.goals_team2 < m.goals_team1)
  end

  def player_won(query, player_id) do
    from m in query,
    where: ((m.keeper_team1_id == ^player_id or m.striker_team1_id == ^player_id) and m.goals_team1 > m.goals_team2 ) or ((m.keeper_team2_id == ^player_id or m.striker_team2_id == ^player_id) and m.goals_team2 > m.goals_team1)
  end

  def zero_goals(query) do
    from m in query,
    where: m.goals_team1 == 0 or m.goals_team2 == 0
  end

  def by_ruleset(query, ruleset_id) do
    from m in query,
    where: m.ruleset_id == ^ruleset_id
  end

  def player_lost_with_zero_goals(query, player_id) do
    from m in query,
    where: ((m.keeper_team1_id == ^player_id or m.striker_team1_id == ^player_id) and m.goals_team1 == 0 ) or ((m.keeper_team2_id == ^player_id or m.striker_team2_id == ^player_id) and m.goals_team2 == 0)
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
