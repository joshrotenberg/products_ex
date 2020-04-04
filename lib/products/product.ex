defmodule Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :__struct__]}

  schema "products" do
    field(:name, :string)
    field(:price, :integer)
    timestamps()
  end

  def changeset(product, attrs \\ %{}) do
    product
    |> cast(attrs, [:name, :price])
    |> validate_required([:name, :price])
  end
end
