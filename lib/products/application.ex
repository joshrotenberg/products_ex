defmodule Products.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      Products.Repo,
      {Plug.Cowboy, scheme: :http, plug: Products.Router, options: [port: port()]}

      # Starts a worker by calling: Products.Worker.start_link(arg)
      # {Products.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Products.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp port, do: Application.get_env(:products, :port, 8080)
end
