defmodule Blog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    create table(:users) do
      add :name, :string, null: false
      add :email, :citext, null: false
      add :token, :string
      add :role, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:token])
  end
end
