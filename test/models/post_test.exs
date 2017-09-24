defmodule ElixirBlog.PostTest do
  use ElixirBlog.ModelCase

  alias ElixirBlog.Post

  @valid_attrs %{author: "some content", body: "some content", category: "some content", image: "some content", likes: 42, sub_category: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end
end
