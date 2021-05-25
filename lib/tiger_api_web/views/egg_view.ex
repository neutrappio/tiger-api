defmodule TigerApiWeb.EggView do
  use TigerApiWeb, :view
  alias TigerApiWeb.EggView

  def render("index.json", %{eggs: eggs}) do
    %{data: render_many(eggs, EggView, "egg.json")}
  end

  def render("show.json", %{egg: egg}) do
    %{data: render_one(egg, EggView, "egg.json")}
  end

  def render("egg.json", %{egg: egg}) do
    %{
      id: egg.id,
      name: egg.name,
      title: egg.title,
      logo: egg.logo,
      description: egg.description,
      tags: egg.tags,
      config: egg.config,
      version: egg.version,
      releasedate: egg.releasedate,
      author: egg.author
    }
  end
end
