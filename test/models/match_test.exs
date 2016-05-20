defmodule KickerWeb.MatchTest do
  use KickerWeb.ModelCase

  alias KickerWeb.Match

  @valid_attrs %{goals_team1: 42, goals_team2: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Match.changeset(%Match{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Match.changeset(%Match{}, @invalid_attrs)
    refute changeset.valid?
  end
end
