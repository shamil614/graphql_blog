# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Blog.{Accounts, Content}

%Accounts.User{}
|> Accounts.User.changeset(%{name: "Test", email: "consumer1@domain.com", token: "fakeRandomToken2", role: "consumer"})
|> Blog.Repo.insert!

user =
  %Accounts.User{}
  |> Accounts.User.changeset(%{name: "Test", email: "admin1@domain.com", token: "fakeRandomToken1", role: "admin"})
  |> Blog.Repo.insert!

Content.create_post(%{author_id: user.id, title: "Test Post", body: "Lorem Ipsum", published_at: ~N[2017-10-26 10:00:00]})
