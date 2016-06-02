defmodule KickerWeb.Repo.Migrations.CreateTable do
  use Ecto.Migration

  def change do
    create table(:tables) do
      add :name, :string

      timestamps
    end

  end
end
