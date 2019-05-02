defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blog.Content.Post

  schema "users" do
    field :email, :string
    field :name, :string
    field :token, :string
    field :role, :string

    has_many :posts, Post, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :token, :role])
    |> validate_required([:name, :email, :role])
    |> unique_constraint(:email, name: :users_email_index)
    |> unique_constraint(:token, name: :users_token_index)
  end
end
