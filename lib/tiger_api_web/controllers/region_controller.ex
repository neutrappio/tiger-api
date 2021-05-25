defmodule TigerApiWeb.RegionController do
  use TigerApiWeb, :controller

  alias TigerApi.Project
  alias TigerApi.Project.Region

  action_fallback TigerApiWeb.FallbackController

  def index(conn, _params) do
    regions = Project.list_regions()
    render(conn, "index.json", regions: regions)
  end

  def create(conn, %{"region" => region_params}) do
    with {:ok, %Region{} = region} <- Project.create_region(region_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.region_path(conn, :show, region))
      |> render("show.json", region: region)
    end
  end

  def show(conn, %{"id" => id}) do
    region = Project.get_region!(id)
    render(conn, "show.json", region: region)
  end

  def update(conn, %{"id" => id, "region" => region_params}) do
    region = Project.get_region!(id)

    with {:ok, %Region{} = region} <- Project.update_region(region, region_params) do
      render(conn, "show.json", region: region)
    end
  end

  def delete(conn, %{"id" => id}) do
    region = Project.get_region!(id)

    with {:ok, %Region{}} <- Project.delete_region(region) do
      send_resp(conn, :no_content, "")
    end
  end
end
