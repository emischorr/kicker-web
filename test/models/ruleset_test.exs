defmodule KickerWeb.RulesetTest do
  use KickerWeb.ModelCase

  alias KickerWeb.Ruleset

  @valid_attrs %{duration_limit: 42, goal_limit: 42, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ruleset.changeset(%Ruleset{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ruleset.changeset(%Ruleset{}, @invalid_attrs)
    refute changeset.valid?
  end
end
