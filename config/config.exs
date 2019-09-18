# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :welcome,
  ecto_repos: [Welcome.Repo]

# Configures the endpoint
config :welcome, WelcomeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YMZg3ygkMTxQNKWkXMfY5nz0C8Z5KgIzlrKa0njpwMWMWBaaJzRzOnDV5t/j60K3",
  render_errors: [view: WelcomeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Welcome.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
