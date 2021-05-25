defmodule TigerApiWeb.NodeView do
  use TigerApiWeb, :view
  alias TigerApiWeb.NodeView

  def render("index.json", %{nodes: nodes}) do
    %{data: render_many(nodes, NodeView, "node.json")}
  end

  def render("show.json", %{node: node}) do
    %{data: render_one(node, NodeView, "node.json")}
  end

  def render("node.json", %{node: node}) do
    %{
      id: node.id,
      name: node.name,
      description: node.description,
      host: node.host,
      ip: node.ip,
      port: node.port,
      username: node.username,
      password: node.password,
      ping: node.ping,
      status: node.status
    }
  end
end
