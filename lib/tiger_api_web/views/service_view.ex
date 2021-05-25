defmodule TigerApiWeb.ServiceView do
  use TigerApiWeb, :view
  alias TigerApiWeb.ServiceView

  def render("index.json", %{services: services}) do
    %{data: render_many(services, ServiceView, "service.json")}
  end

  def render("show.json", %{service: service}) do
    %{data: render_one(service, ServiceView, "service.json")}
  end

  def render("service.json", %{service: service}) do
    %{id: service.id,
      name: service.name,
      description: service.description,
      tags: service.tags,
      config: service.config,
      version: service.version,
      author: service.author}
  end
end
