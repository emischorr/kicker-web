defmodule KickerWeb.Table do
  use KickerWeb.Web, :model

  schema "tables" do
    field :name, :string

    timestamps()
  end

  @required_fields ~w(name)a
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
