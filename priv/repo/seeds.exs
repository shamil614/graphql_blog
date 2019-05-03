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

consumer_user =
  %Accounts.User{}
  |> Accounts.User.changeset(%{
    name: "Test",
    email: "consumer1@domain.com",
    token: "fakeConsumerToken",
    role: "consumer"
  })
  |> Blog.Repo.insert!()

Content.create_post(%{
  private_notes: "Private note only for the admin",
  author_id: consumer_user.id,
  title: "Consumer Test Post",
  body: "Lorem Ipsum",
  published_at: ~N[2018-11-26 10:00:00]
})

admin_user =
  %Accounts.User{}
  |> Accounts.User.changeset(%{
    name: "Test",
    email: "admin1@domain.com",
    token: "fakeAdminToken",
    role: "admin"
  })
  |> Blog.Repo.insert!()

Content.create_post(%{
  private_notes: "Private note only for the admin",
  author_id: admin_user.id,
  title: "Admin Test Post",
  body: "Lorem Ipsum",
  published_at: ~N[2018-11-26 10:00:00]
})
