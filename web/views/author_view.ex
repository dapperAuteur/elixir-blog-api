defmodule ElixirBlog.AuthorView do
  use ElixirBlog.Web, :view
  use JaSerializer.PhoenixView

  attributes [:username, :image, :password, :email, :inserted_at, :updated_at]
  

end
