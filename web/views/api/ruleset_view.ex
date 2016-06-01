defmodule KickerWeb.API.RulesetView do
  use KickerWeb.Web, :view

  def render("index.json", %{rulesets: rulesets}) do
    %{data: render_many(rulesets, KickerWeb.API.RulesetView, "ruleset.json")}
  end

  def render("show.json", %{ruleset: ruleset}) do
    %{data: render_one(ruleset, KickerWeb.API.RulesetView, "ruleset.json")}
  end

  def render("ruleset.json", %{ruleset: ruleset}) do
    %{id: ruleset.id,
      name: ruleset.name,
      goal_limit: ruleset.goal_limit,
      duration_limit: ruleset.duration_limit}
  end
end
