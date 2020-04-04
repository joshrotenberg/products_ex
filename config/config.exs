import Config

config :products, Products.Repo,
  database: "products_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :products,
  # divo: "test/support/docker-compose.yaml",
  ecto_repos: [Products.Repo]

config :products,
  divo: %{
    version: "3",
    services: %{
      redis: %{
        image: "redis:latest",
        ports: [
          "6379:6379"
        ],
        healthcheck: %{
          test: ["CMD", "redis-cli", "PING"],
          interval: "5s",
          timeout: "10s",
          retries: 3
        }
      }
    }
  },
  divo_wait: [dwell: 700, max_tries: 50]

import_config "#{Mix.env()}.exs"
