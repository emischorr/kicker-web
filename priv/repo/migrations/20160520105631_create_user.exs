defmodule KickerWeb.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :encrypted_password, :string, null: false

      timestamps
    end

    create index(:players, [:email])

  end
end
