defmodule ElixirBlog.Post do
  use ElixirBlog.Web, :model

  schema "posts" do
    field :title, :string
    field :image, :string
    field :body, :string
    field :likes, :integer
    field :author, :string
    field :category, :string
    field :sub_category, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :image, :body, :likes, :author, :category, :sub_category])
    |> validate_required([:title, :image, :body, :likes, :author, :category, :sub_category])
  end
end
