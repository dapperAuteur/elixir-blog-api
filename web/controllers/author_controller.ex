defmodule ElixirBlog.AuthorController do
  use ElixirBlog.Web, :controller

  alias ElixirBlog.Author
  alias JaSerializer.Params

  plug :scrub_params, "data" when action in [:create, :update]

  def index(conn, _params) do
    authors = Repo.all(Author)
    render(conn, "index.json-api", data: authors)
  end

  def create(conn, %{"data" => data = %{"type" => "author", "attributes" => _author_params}}) do
    changeset = Author.changeset(%Author{}, Params.to_attributes(data))

    case Repo.insert(changeset) do
      {:ok, author} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", author_path(conn, :show, author))
        |> render("show.json-api", data: author)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    author = Repo.get!(Author, id)
    render(conn, "show.json-api", data: author)
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "author", "attributes" => _author_params}}) do
    author = Repo.get!(Author, id)
    changeset = Author.changeset(author, Params.to_attributes(data))

    case Repo.update(changeset) do
      {:ok, author} ->
        render(conn, "show.json-api", data: author)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    author = Repo.get!(Author, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(author)

    send_resp(conn, :no_content, "")
  end

end
