defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :string
      add :published_at, :naive_datetime
      add :author_id, references(:users), null: false
      add :private_notes, :string

      timestamps()
    end

    create index(:posts, [:author_id])
  end
end
