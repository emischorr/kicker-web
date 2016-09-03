defmodule KickerWeb.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :goals_team1, :integer
      add :goals_team2, :integer

      add :keeper_team1_id, references(:players)
      add :striker_team1_id, references(:players)
      add :keeper_team2_id, references(:players)
      add :striker_team2_id, references(:players)

      timestamps
    end

  end
end
