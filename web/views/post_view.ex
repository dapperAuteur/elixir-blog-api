defmodule ElixirBlog.PostView do
  use ElixirBlog.Web, :view
  use JaSerializer.PhoenixView

  attributes [:title, :image, :body, :likes, :author, :category, :sub_category, :inserted_at, :updated_at]
  

end
