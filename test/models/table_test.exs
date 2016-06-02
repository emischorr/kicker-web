defmodule KickerWeb.TableTest do
  use KickerWeb.ModelCase

  alias KickerWeb.Table

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Table.changeset(%Table{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Table.changeset(%Table{}, @invalid_attrs)
    refute changeset.valid?
  end
end
