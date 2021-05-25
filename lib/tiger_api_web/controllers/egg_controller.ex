defmodule TigerApiWeb.EggController do
  use TigerApiWeb, :controller

  alias TigerApi.Project
  alias TigerApi.Project.Egg

  action_fallback TigerApiWeb.FallbackController

  def index(conn, _params) do
    eggs = Project.list_eggs()
    render(conn, "index.json", eggs: eggs)
  end

  def create(conn, %{"egg" => egg_params}) do
    with {:ok, %Egg{} = egg} <- Project.create_egg(egg_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.egg_path(conn, :show, egg))
      |> render("show.json", egg: egg)
    end
  end

  def show(conn, %{"id" => id}) do
    egg = Project.get_egg!(id)
    render(conn, "show.json", egg: egg)
  end

  def update(conn, %{"id" => id, "egg" => egg_params}) do
    egg = Project.get_egg!(id)

    with {:ok, %Egg{} = egg} <- Project.update_egg(egg, egg_params) do
      render(conn, "show.json", egg: egg)
    end
  end

  def delete(conn, %{"id" => id}) do
    egg = Project.get_egg!(id)

    with {:ok, %Egg{}} <- Project.delete_egg(egg) do
      send_resp(conn, :no_content, "")
    end
  end
end
