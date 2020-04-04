defmodule Products.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Products.Repo

      import Ecto
      import Ecto.Query
      import Products.RepoCase
      import Products.Factory
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Products.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Products.Repo, {:shared, self()})
    end

    :ok
  end
end
