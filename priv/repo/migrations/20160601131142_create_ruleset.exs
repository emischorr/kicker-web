defmodule KickerWeb.Repo.Migrations.CreateRuleset do
  use Ecto.Migration

  def change do
    create table(:rulesets) do
      add :name, :string, null: false
      add :goal_limit, :integer, default: 5, null: false
      add :duration_limit, :integer, default: 0, null: false

      timestamps
    end

  end
end
