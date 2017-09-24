defmodule ElixirBlog.Router do
  use ElixirBlog.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/api", ElixirBlog do
    pipe_through :api
  end
end
