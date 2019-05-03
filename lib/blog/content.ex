defmodule Blog.Content do
  alias Blog.Repo
  alias Blog.Content.Post
  alias Blog.Accounts.User

  import Ecto.Query

  def create_post(params, author) do
    params
    |> Map.put(:author_id, author.id)
    |> create_post()
  end

  def create_post(params) do
    %Post{}
    |> Post.changeset(params)
    |> Repo.insert!()
  end

  def list_posts do
    Repo.all(Post)
  end

  def list_posts(args, current_user = %User{}) do
    Post
    |> authorize_posts(current_user)
    |> post_args_to_query(args)
    |> Repo.all()
  end

  def list_posts_by_author(args, author = %User{}, _current_user) do
    Post
    |> by_author(author)
    |> post_args_to_query(args)
    |> Repo.all()
  end

  def authorize_post_field(post, :private_notes, _current_user = %User{role: "admin"}) do
    {:ok, Map.get(post, :private_notes)}
  end

  def authorize_post_field(_post, :private_notes, _current_user = %User{}) do
    {:error, "Field not authorized"}
  end

  # Admin can see all posts
  defp authorize_posts(query, %User{role: "admin"}) do
    query
  end

  # Consumer can only see their posts
  defp authorize_posts(query, current_user = %User{role: "consumer"}) do
    query
    |> by_author(current_user)
  end

  defp by_author(query, %User{id: id}) do
    query
    |> where([p], p.author_id == ^id)
  end

  defp post_args_to_query(query, args) do
    Enum.reduce(args, query, fn {key, val}, acc_query ->
      acc_query
      |> post_arg_to_query({key, val})
    end)
  end

  defp post_arg_to_query(query, {:date, date}) do
    where(query, [p], fragment("date_trunc('day', ?)", p.published_at) == type(^date, :date))
  end
end
