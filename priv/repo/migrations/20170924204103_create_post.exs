defmodule ElixirBlog.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :image, :string
      add :body, :string
      add :likes, :integer
      add :author, :string
      add :category, :string
      add :sub_category, :string

      timestamps()
    end

  end
end
