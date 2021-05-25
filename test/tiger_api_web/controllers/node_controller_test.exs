defmodule TigerApiWeb.NodeControllerTest do
  use TigerApiWeb.ConnCase

  alias TigerApi.Project
  alias TigerApi.Project.Node

  @create_attrs %{
    description: "some description",
    host: "some host",
    ip: "some ip",
    name: "some name",
    password: "some password",
    ping: ~N[2010-04-17 14:00:00],
    port: "some port",
    status: true,
    username: "some username"
  }
  @update_attrs %{
    description: "some updated description",
    host: "some updated host",
    ip: "some updated ip",
    name: "some updated name",
    password: "some updated password",
    ping: ~N[2011-05-18 15:01:01],
    port: "some updated port",
    status: false,
    username: "some updated username"
  }
  @invalid_attrs %{
    description: nil,
    host: nil,
    ip: nil,
    name: nil,
    password: nil,
    ping: nil,
    port: nil,
    status: nil,
    username: nil
  }

  def fixture(:node) do
    {:ok, node} = Project.create_node(@create_attrs)
    node
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all nodes", %{conn: conn} do
      conn = get(conn, Routes.node_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create node" do
    test "renders node when data is valid", %{conn: conn} do
      conn = post(conn, Routes.node_path(conn, :create), node: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.node_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "host" => "some host",
               "ip" => "some ip",
               "name" => "some name",
               "password" => "some password",
               "ping" => "2010-04-17T14:00:00",
               "port" => "some port",
               "status" => true,
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.node_path(conn, :create), node: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update node" do
    setup [:create_node]

    test "renders node when data is valid", %{conn: conn, node: %Node{id: id} = node} do
      conn = put(conn, Routes.node_path(conn, :update, node), node: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.node_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "host" => "some updated host",
               "ip" => "some updated ip",
               "name" => "some updated name",
               "password" => "some updated password",
               "ping" => "2011-05-18T15:01:01",
               "port" => "some updated port",
               "status" => false,
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, node: node} do
      conn = put(conn, Routes.node_path(conn, :update, node), node: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete node" do
    setup [:create_node]

    test "deletes chosen node", %{conn: conn, node: node} do
      conn = delete(conn, Routes.node_path(conn, :delete, node))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.node_path(conn, :show, node))
      end
    end
  end

  defp create_node(_) do
    node = fixture(:node)
    %{node: node}
  end
end
