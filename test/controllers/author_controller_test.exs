defmodule ElixirBlog.AuthorControllerTest do
  use ElixirBlog.ConnCase

  alias ElixirBlog.Author
  alias ElixirBlog.Repo

  @valid_attrs %{email: "some content", image: "some content", password: "some content", username: "some content"}
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
    conn = get conn, author_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = get conn, author_path(conn, :show, author)
    data = json_response(conn, 200)["data"]
    assert data["id"] == "#{author.id}"
    assert data["type"] == "author"
    assert data["attributes"]["username"] == author.username
    assert data["attributes"]["image"] == author.image
    assert data["attributes"]["password"] == author.password
    assert data["attributes"]["email"] == author.email
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, author_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, author_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "author",
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Author, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, author_path(conn, :create), %{
      "meta" => %{},
      "data" => %{
        "type" => "author",
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = put conn, author_path(conn, :update, author), %{
      "meta" => %{},
      "data" => %{
        "type" => "author",
        "id" => author.id,
        "attributes" => @valid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Author, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = put conn, author_path(conn, :update, author), %{
      "meta" => %{},
      "data" => %{
        "type" => "author",
        "id" => author.id,
        "attributes" => @invalid_attrs,
        "relationships" => relationships
      }
    }

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    author = Repo.insert! %Author{}
    conn = delete conn, author_path(conn, :delete, author)
    assert response(conn, 204)
    refute Repo.get(Author, author.id)
  end

end
