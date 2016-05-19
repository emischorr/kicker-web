defmodule KickerWeb.Router do
  use KickerWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :minimal_layout do
    plug :put_layout, {KickerWeb.LayoutView, :minimal}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KickerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", DashboardController, :index
    get "/live", DashboardController, :live
    post "/start", DashboardController, :start
  end

  # Other scopes may use custom stacks.
  # scope "/api", KickerWeb do
  #   pipe_through :api
  # end
end
