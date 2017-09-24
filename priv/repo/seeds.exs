# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirBlog.Repo.insert!(%ElixirBlog.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ElixirBlog.Repo
alias ElixirBlog.Post

[
  %Post{
    title: "Why do I like Elixir",
    image: "https://avatars0.githubusercontent.com/u/1481354?v=4&s=400",
    body: "I like Elixir a lot",
    likes: 5,
    author: "aweful",
    category: "software development",
    sub_category: "elixir"
  },
  %Post{
    title: "Why do I like Vue.JS",
    image: "http://pespantelis.github.io/vue-videobg/demo/assets/logo.png",
    body: "I like Vue.JS a lot",
    likes: 7,
    author: "aweful",
    category: "software development",
    sub_category: "vuejs"
  }
] |> Enum.each(&Repo.insert!(&1))
