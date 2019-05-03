defmodule BlogWeb.Resolvers.Content do
  alias Blog.Accounts.User
  alias Blog.Content
  alias Blog.Content.Post

  def authorize_post_field(post = %Post{}, field, %{context: %{current_user: current_user}}) do
    Content.authorize_post_field(post, field, current_user)
  end

  def authorize_post_field(_post, _field, _) do
    {:error, "Not authorized for field"}
  end

  @doc """
  Resolve Posts associated to a User
  """
  def list_posts(%User{} = author, args, %{context: %{current_user: current_user}}) do
    {:ok, Content.list_posts_by_author(args, author, current_user)}
  end

  @doc """
  Resolve Posts.
  """
  def list_posts(_parent, args, %{context: %{current_user: current_user}}) do
    {:ok, Content.list_posts(args, current_user)}
  end

  def create_post(_parent, args, %{context: %{current_user: current_user}}) do
    post = Content.create_post(args, current_user)
    {:ok, post}
  end

  def create_post(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end
end
