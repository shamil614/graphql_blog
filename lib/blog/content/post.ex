defmodule Blog.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Accounts.User

  schema "posts" do
    field :body, :string
    field :title, :string
    field :published_at, :naive_datetime
    field :private_notes, :string

    belongs_to :author, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :published_at, :author_id, :private_notes])
    |> validate_required([:title, :body, :author_id])
  end
end
