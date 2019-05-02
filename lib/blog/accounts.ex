defmodule Blog.Accounts do
  alias Blog.Repo
  alias Blog.Accounts.User

  import Ecto.Query

  def find_user(id) do
    Repo.one(from u in User, where: u.id == ^id)
  end
end
