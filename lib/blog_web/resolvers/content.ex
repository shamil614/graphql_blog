defmodule BlogWeb.Resolvers.Content do
  alias Blog.Accounts.User

  @doc """
  Resolve Posts associated to a User
  """
  def list_posts(%User{} = author, args, _resolution) do
    {:ok, Blog.Content.list_posts(author, args)}
  end

  @doc """
  Resolve Posts.
  """
  def list_posts(_parent, args, %{context: %{current_user: user}}) do
    {:ok, Blog.Content.list_posts(user, args)}
  end

  def create_post(_parent, args, %{context: %{current_user: user}}) do
    post = Blog.Content.create_post(user, args)
    {:ok, post}
  end

  def create_post(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end
end
