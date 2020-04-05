import Config

config :products, Products.Repo,
  username: "postgres",
  password: "postgres",
  database: "products_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :products,
  port: 4002
