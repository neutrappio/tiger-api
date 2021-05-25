defmodule TigerApiWeb.ServiceController do
  use TigerApiWeb, :controller

  alias TigerApi.Project
  alias TigerApi.Project.Service

  action_fallback TigerApiWeb.FallbackController

  def index(conn, _params) do
    services = Project.list_services()
    render(conn, "index.json", services: services)
  end

  def create(conn, %{"service" => service_params}) do
    with {:ok, %Service{} = service} <- Project.create_service(service_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.service_path(conn, :show, service))
      |> render("show.json", service: service)
    end
  end

  def show(conn, %{"id" => id}) do
    service = Project.get_service!(id)
    render(conn, "show.json", service: service)
  end

  def update(conn, %{"id" => id, "service" => service_params}) do
    service = Project.get_service!(id)

    with {:ok, %Service{} = service} <- Project.update_service(service, service_params) do
      render(conn, "show.json", service: service)
    end
  end

  def delete(conn, %{"id" => id}) do
    service = Project.get_service!(id)

    with {:ok, %Service{}} <- Project.delete_service(service) do
      send_resp(conn, :no_content, "")
    end
  end
end
