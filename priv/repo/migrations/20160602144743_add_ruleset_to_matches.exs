defmodule KickerWeb.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :ruleset_id, references(:rulesets)
    end
  end
end
