defmodule TigerApiWeb.NodeController do
  use TigerApiWeb, :controller

  alias TigerApi.Project
  alias TigerApi.Project.Node

  action_fallback TigerApiWeb.FallbackController

  def index(conn, _params) do
    nodes = Project.list_nodes()
    render(conn, "index.json", nodes: nodes)
  end

  def create(conn, %{"node" => node_params}) do
    with {:ok, %Node{} = node} <- Project.create_node(node_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.node_path(conn, :show, node))
      |> render("show.json", node: node)
    end
  end

  def show(conn, %{"id" => id}) do
    node = Project.get_node!(id)
    render(conn, "show.json", node: node)
  end

  def update(conn, %{"id" => id, "node" => node_params}) do
    node = Project.get_node!(id)

    with {:ok, %Node{} = node} <- Project.update_node(node, node_params) do
      render(conn, "show.json", node: node)
    end
  end

  def delete(conn, %{"id" => id}) do
    node = Project.get_node!(id)

    with {:ok, %Node{}} <- Project.delete_node(node) do
      send_resp(conn, :no_content, "")
    end
  end
end
