defmodule Products.Router do
  use Plug.Router

  require Logger

  def init(options) do
    options
  end

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)

  plug(:dispatch)

  post "/product" do
    {status, body} =
      case create_product(conn.body_params) do
        {:ok, product} -> {201, product}
        {:error, changeset} -> {400, changeset |> format_errors()}
      end

    send_resp(conn, status, Jason.encode!(body))
  end

  put "/product/:id" do
    {status, body} =
      case update_product(id, conn.body_params) do
        {:ok, product} -> {200, product}
        {:error, changeset} -> {400, changeset |> format_errors()}
      end

    send_resp(conn, status, Jason.encode!(body))
  end

  get "/product/:id" do
    {status, body} =
      case get_product(id) do
        %Products.Product{} = product -> {200, product}
        nil -> {404, %{error: "No product found for id #{id}"}}
      end

    send_resp(conn, status, Jason.encode!(body))
  end

  delete "/product/:id" do
    {status, body} =
      case delete_product(id) do
        {:ok, product} -> {200, product}
        nil -> {404, %{error: "No product found for id #{id}"}}
        {:error, error} -> {400, error}
      end

    send_resp(conn, status, Jason.encode!(body))
  end

  match _ do
    send_resp(conn, 404, Jason.encode!("Not found"))
  end

  defp create_product(attrs) do
    %Products.Product{}
    |> Products.Product.changeset(attrs)
    |> Products.Repo.insert()
  end

  defp update_product(id, attrs) do
    product = Products.Product |> Products.Repo.get(id)

    product
    |> Products.Product.changeset(attrs)
    |> Products.Repo.update()
  end

  defp get_product(id) do
    try do
      Products.Product
      |> Products.Repo.get(id)
    rescue
      e in Ecto.Query.CastError ->
        Logger.warn(e.message)
        nil
    end
  end

  defp delete_product(id) do
    try do
      case Products.Product |> Products.Repo.get(id) do
        nil ->
          nil

        product ->
          Products.Repo.delete(product)
      end
    rescue
      e in Ecto.Query.CastError ->
        Logger.warn(e.message)
        nil
    end
  end

  def format_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
