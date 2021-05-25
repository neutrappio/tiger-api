defmodule TigerApiWeb.RegionView do
  use TigerApiWeb, :view
  alias TigerApiWeb.RegionView

  def render("index.json", %{regions: regions}) do
    %{data: render_many(regions, RegionView, "region.json")}
  end

  def render("show.json", %{region: region}) do
    %{data: render_one(region, RegionView, "region.json")}
  end

  def render("region.json", %{region: region}) do
    %{
      id: region.id,
      name: region.name,
      continent: region.continent,
      description: region.description,
      status: region.status
    }
  end
end
