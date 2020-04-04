defmodule Products.Factory do
  alias Products.Repo

  def build(:product, attrs \\ %{name: "product", price: 20}) do
    struct(Products.Product, attrs)
  end

  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    Repo.insert!(build(factory_name, attributes))
  end

  def delete!(factory_name, attributes \\ []) do
    Repo.delete!(build(factory_name, attributes))
  end
end
