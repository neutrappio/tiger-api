# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tiger_api,
  ecto_repos: [TigerApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :tiger_api, TigerApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "szByd0z/O9Z27QQkg7VoZOFs+WV8+v7O5LD8ObD1AmKuevWeF2MYpfJptQ9ubq9U",
  render_errors: [view: TigerApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TigerApi.PubSub,
  live_view: [signing_salt: "BXNsUa8n"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
