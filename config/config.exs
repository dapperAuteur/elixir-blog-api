# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elixir_blog,
  ecto_repos: [ElixirBlog.Repo]

# Configures the endpoint
config :elixir_blog, ElixirBlog.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xap7U+UDcDwI9OejYSHhqM8VuvX7Jbw4j43TrIJMXjGG3Nze/Owo60x3mYCI8XQj",
  render_errors: [view: ElixirBlog.ErrorView, accepts: ~w(json)],
  pubsub: [name: ElixirBlog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders,
    "json-api": Poison

  config :plug, :mimes, %{
    "application/vnd.api+json" => ["json-api"]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
