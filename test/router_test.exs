defmodule Products.RouterTest do
  use Products.RepoCase
  use Plug.Test

  @opts Products.Router.init([])

  setup do
    :ok
  end

  describe "create" do
    test "create a product" do
      product = %{name: "product 1", price: 20}
      conn = conn(:post, "/product", product)

      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert resp["name"] == product.name
      assert resp["price"] == product.price
    end

    test "create a product with a missing price" do
      product = %{name: "product 2"}
      conn = conn(:post, "/product", product)

      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 400
      assert resp["price"] == ["can't be blank"]
    end

    test "create a product with a missing name" do
      product = %{price: 20}
      conn = conn(:post, "/product", product)

      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 400
      assert resp["name"] == ["can't be blank"]
    end

    test "create an empty product" do
      product = %{}
      conn = conn(:post, "/product", product)

      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 400
      assert resp["name"] == ["can't be blank"]
      assert resp["price"] == ["can't be blank"]
    end

    test "create a product with an incorrect type" do
      product = %{name: "product", price: "not a price"}
      conn = conn(:post, "/product", product)

      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 400
      assert resp["price"] == ["is invalid"]
    end
  end

  describe "update" do
    test "update a product's price" do
      product = insert!(:product, name: "product 1", price: 50)
      new_price = 60

      conn = conn(:put, "/product/#{product.id}", %{price: new_price})
      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert resp["id"] == product.id
      assert resp["name"] == product.name
      assert resp["price"] == new_price
    end

    test "update a product's name and price" do
      product = insert!(:product, name: "product 1", price: 50)
      new_name = "product 1.5"
      new_price = 60

      conn = conn(:put, "/product/#{product.id}", %{name: new_name, price: new_price})
      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 200
      assert resp["id"] == product.id
      assert resp["name"] == new_name
      assert resp["price"] == new_price
    end

    test "update a product with an invalid name" do
      product = insert!(:product, name: "product 1", price: 50)
      new_name = 50

      conn = conn(:put, "/product/#{product.id}", %{name: new_name})
      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 400
      assert resp["name"] == ["is invalid"]
    end

    test "update a product with an invalid price" do
      product = insert!(:product, name: "product 1", price: 50)
      new_price = "not a price"

      conn = conn(:put, "/product/#{product.id}", %{price: new_price})
      conn = Products.Router.call(conn, @opts)

      resp = Jason.decode!(conn.resp_body)

      assert conn.state == :sent
      assert conn.status == 400
      assert resp["price"] == ["is invalid"]
    end
  end

  describe "fetch" do
    test "fetch a product by id" do
      product = insert!(:product, name: "doof", price: 50)

      conn =
        conn(:get, "/product/#{product.id}")
        |> Products.Router.call(@opts)

      resp = Jason.decode!(conn.resp_body)
      assert conn.state == :sent
      assert conn.status == 200
      assert product.id == resp["id"]
      assert product.name == resp["name"]
      assert product.price == resp["price"]
    end

    test "fetch a product that doesn't exist" do
      missing_id = 54_321

      conn =
        conn(:get, "/product/#{missing_id}")
        |> Products.Router.call(@opts)

      resp = Jason.decode!(conn.resp_body)
      assert conn.state == :sent
      assert conn.status == 404
      assert resp["error"] == "No product found for id #{missing_id}"
    end

    test "fetch a product with a malformed id" do
      malformed_id = "this-is-not-an-id"

      conn =
        conn(:get, "/product/#{malformed_id}")
        |> Products.Router.call(@opts)

      resp = Jason.decode!(conn.resp_body)
      assert conn.state == :sent
      assert conn.status == 404
      assert resp["error"] == "No product found for id #{malformed_id}"
    end
  end

  describe "delete" do
    test "delete a product" do
      product = insert!(:product, name: "doof", price: 50)

      conn =
        conn(:delete, "/product/#{product.id}")
        |> Products.Router.call(@opts)

      resp = Jason.decode!(conn.resp_body)
      assert conn.state == :sent
      assert conn.status == 200
      assert resp["id"] == product.id
      assert resp["name"] == product.name
      assert resp["price"] == product.price
    end
  end
end
