defmodule KickerWeb.Player do
  use KickerWeb.Web, :model

  schema "players" do
    field :name, :string
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @required_fields ~w(name email)
  @optional_fields ~w()

  def authenticate?(player_param) do
    query = from u in KickerWeb.Player,
      where: u.email == ^player_param.changes.email

    player = KickerWeb.Repo.one query

    if player && password_correct?(player, player_param.changes.password) do
      player
    else
      nil
    end
  end

  def password_correct?(player, password) do
    Comeonin.Bcrypt.checkpw(password, player.encrypted_password)
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset
    end
  end

  defp cast_password(changeset, params) do
    case get_field(changeset, :encrypted_password) do
      nil -> cast(changeset, params, ~w(password), ~w())
      _ -> cast(changeset, params, ~w(), ~w(password))
    end
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_password(params)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password
  end
end
