# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :cat_diary_poc,
  ecto_repos: [CatDiaryPoc.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :cat_diary_poc, CatDiaryPoc.Mailer, adapter: Swoosh.Adapters.Local

config :cat_diary_poc_web,
  ecto_repos: [CatDiaryPoc.Repo],
  generators: [context_app: :cat_diary_poc]

# Configures the endpoint
config :cat_diary_poc_web, CatDiaryPocWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: CatDiaryPocWeb.ErrorHTML, json: CatDiaryPocWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: CatDiaryPoc.PubSub,
  live_view: [signing_salt: "JNrE8fZW"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  cat_diary_poc_web: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/cat_diary_poc_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.0",
  cat_diary_poc_web: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/cat_diary_poc_web/assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
