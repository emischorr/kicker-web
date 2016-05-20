defmodule KickerWeb.Match do
  use KickerWeb.Web, :model

  schema "matches" do
    field :goals_team1, :integer
    field :goals_team2, :integer

    timestamps
  end

  @required_fields ~w(goals_team1 goals_team2)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
