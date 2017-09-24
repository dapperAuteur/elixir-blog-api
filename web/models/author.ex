defmodule ElixirBlog.Author do
  use ElixirBlog.Web, :model

  schema "authors" do
    field :username, :string
    field :image, :string
    field :password, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :image, :password, :email])
    |> validate_required([:username, :image, :password, :email])
  end
end
