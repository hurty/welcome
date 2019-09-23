defmodule WelcomeWeb.Router do
  use WelcomeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WelcomeWeb do
    pipe_through :browser

    get "/", BoardController, :index
    live "/boardlive", BoardLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", WelcomeWeb do
  #   pipe_through :api
  # end
end
