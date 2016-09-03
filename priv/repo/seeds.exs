# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     KickerWeb.Repo.insert!(%KickerWeb.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

KickerWeb.Repo.insert(%KickerWeb.Table{name: "Kicker"})

KickerWeb.Repo.insert(%KickerWeb.Ruleset{name: "default match", goal_limit: 5, duration_limit: 0 })
KickerWeb.Repo.insert(%KickerWeb.Ruleset{name: "death match", goal_limit: 1, duration_limit: 0 })
KickerWeb.Repo.insert(%KickerWeb.Ruleset{name: "competition match", goal_limit: 10, duration_limit: 5*60 })
