defmodule KickerWeb.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :goals_team1, :integer
      add :goals_team2, :integer

      timestamps
    end

  end
end
