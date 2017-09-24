defmodule ElixirBlog.PostControllerTest do
  use ElixirBlog.ConnCase

  alias ElixirBlog.Post
  alias ElixirBlog.Repo

  @valid_attrs %{author: "some content", body: "some content", category: "some content", image: "some content", likes: 42, sub_category: "some content", title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = build_conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")

    {:ok, conn: conn}
  end
  
  defp relationships do
    %{}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, post_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = get conn, post_path(conn, :show, post)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{post.id}"
    assert data["type"] == "post"
    assert data["attributes"]["title"] == post.title
    assert data["attributes"]["image"] == post.image
    assert data["attributes"]["body"] == post.body
    assert data["attributes"]["likes"] == post.likes
    assert data["attributes"]["author"] == post.author
    assert data["attributes"]["category"] == post.category
    assert data["attributes"]["sub_category"] == post.sub_category
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, post_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, post_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "post",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, post_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "post",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = put conn, post_path(conn, :update, post), %{
      "meta" => %{},
      "data" => %{
        "type" => "post",
        "id" => post.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = put conn, post_path(conn, :update, post), %{
      "meta" => %{},
      "data" => %{
        "type" => "post",
        "id" => post.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = delete conn, post_path(conn, :delete, post)
    assert response(conn, 204)
    refute Repo.get(Post, post.id)
  end

end
