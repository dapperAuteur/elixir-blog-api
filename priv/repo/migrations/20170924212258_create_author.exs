defmodule ElixirBlog.Repo.Migrations.CreateAuthor do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :username, :string
      add :image, :string
      add :password, :string
      add :email, :string

      timestamps()
    end

  end
end
