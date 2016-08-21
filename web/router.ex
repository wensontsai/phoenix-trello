defmodule PhoenixTrello.Router do
  use PhoenixTrello.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/", PhoenixTrello do
    pipe_through :browser # Use the default browser stack

    # get "/", PageController, :index
    get "*path", PageController, :index
  end

  scope "/api", PhoenixTrello do
    pipe_through :api

    scope "/v1" do
      post "/registrations", RegistrationController, :create

      get "/current_user", CurrentUserController, :show

      post "/sessions", SessionController, :delete
      delete "/sessions", SessionController, :delete
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixTrello do
  #   pipe_through :api
  # end
end
