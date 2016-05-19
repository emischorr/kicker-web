ExUnit.start

Mix.Task.run "ecto.create", ~w(-r KickerWeb.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r KickerWeb.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(KickerWeb.Repo)

