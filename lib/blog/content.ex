defmodule Blog.Content do
  alias Blog.Repo
  alias Blog.Content.Post
  alias Blog.Accounts.User

  import Ecto.Query

  def list_posts(author = %User{}, %{date: date}) do
    query = from(t in Post,
      where: fragment("date_trunc('day', ?)", t.published_at) == type(^date, :date))

    query
    |> authorize_posts(author)
    |> Repo.all()
  end

  def list_posts(author = %User{}, _args = %{}) do
    Post
    |> authorize_posts(author)
    |> Repo.all()
  end

  def authorize_posts(query, %User{role: "admin"}) do
    query
  end

  def authorize_posts(query, %User{id: id, role: "consumer"}) do
    query
    |> where([p], p.author_id == ^id )
  end

  def list_posts do
    Repo.all(Post)
  end

  def create_post(user, params) do
    params
    |> Map.put(:author_id, user.id)
    |> create_post()
  end

  def create_post(params) do
    %Post{}
    |> Post.changeset(params)
    |> Repo.insert!()
  end
end
