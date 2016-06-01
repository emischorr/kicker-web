defmodule KickerWeb.RulesetControllerTest do
  use KickerWeb.ConnCase

  alias KickerWeb.Ruleset
  @valid_attrs %{duration_limit: 42, goal_limit: 42, name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, ruleset_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    ruleset = Repo.insert! %Ruleset{}
    conn = get conn, ruleset_path(conn, :show, ruleset)
    assert json_response(conn, 200)["data"] == %{"id" => ruleset.id,
      "name" => ruleset.name,
      "goal_limit" => ruleset.goal_limit,
      "duration_limit" => ruleset.duration_limit}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, ruleset_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, ruleset_path(conn, :create), ruleset: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Ruleset, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, ruleset_path(conn, :create), ruleset: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    ruleset = Repo.insert! %Ruleset{}
    conn = put conn, ruleset_path(conn, :update, ruleset), ruleset: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Ruleset, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    ruleset = Repo.insert! %Ruleset{}
    conn = put conn, ruleset_path(conn, :update, ruleset), ruleset: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    ruleset = Repo.insert! %Ruleset{}
    conn = delete conn, ruleset_path(conn, :delete, ruleset)
    assert response(conn, 204)
    refute Repo.get(Ruleset, ruleset.id)
  end
end
