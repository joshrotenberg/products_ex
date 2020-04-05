import Config

config :products, Products.Repo,
  database: "products_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :products,
  port: 4001,
  ecto_repos: [Products.Repo]

import_config "#{Mix.env()}.exs"
