defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug BlogWeb.Plugs.Context
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: BlogWeb.Schema, json_codec: Phoenix.json_library()

    forward "/", Absinthe.Plug,
      schema: BlogWeb.Schema
  end
end
