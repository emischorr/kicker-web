defmodule KickerWeb.Ruleset do
  use KickerWeb.Web, :model

  schema "rulesets" do
    field :name, :string
    field :goal_limit, :integer
    field :duration_limit, :integer

    has_many :matches, KickerWeb.Match

    timestamps()
  end

  @required_fields ~w(name goal_limit duration_limit)a
  @optional_fields ~w()a

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
