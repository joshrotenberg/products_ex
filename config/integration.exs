import Config

config :products, Products.Repo,
  username: "postgres",
  password: "postgres",
  database: "products_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

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

# IO.puts("djknqwe")

# config :products,
#
# config :products,
#   divo: [
#     {DivoPostgres,
#      [
#        user: "postgres",
#        password: "postgres",
#        database: "products_test",
#        hostname: "localhost"
#      ]}
#   ]
