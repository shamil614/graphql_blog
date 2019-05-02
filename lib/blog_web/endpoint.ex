defmodule BlogWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :blog

  plug(Plug.Static,
    at: "/",
    from: :acd,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)
  )

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
    #json_decoder: Phoenix.json_library()

  plug(BlogWeb.Router)
end
