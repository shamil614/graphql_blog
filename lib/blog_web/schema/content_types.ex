defmodule BlogWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  alias BlogWeb.Resolvers

  object :post do
    field :id, :id
    field :title, :string
    field :body, :string
    field :author, :user
    field :published_at, :naive_datetime
    field :private_notes, :string do
      resolve(fn(post, _, context) ->
        Resolvers.Content.authorize_post_field(post, :private_notes, context)
      end)
    end
  end
end
