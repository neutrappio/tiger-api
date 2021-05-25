defmodule TigerApiWeb.ServiceControllerTest do
  use TigerApiWeb.ConnCase

  alias TigerApi.Project
  alias TigerApi.Project.Service

  @create_attrs %{
    author: "some author",
    config: "some config",
    description: "some description",
    name: "some name",
    tags: [],
    version: "some version"
  }
  @update_attrs %{
    author: "some updated author",
    config: "some updated config",
    description: "some updated description",
    name: "some updated name",
    tags: [],
    version: "some updated version"
  }
  @invalid_attrs %{author: nil, config: nil, description: nil, name: nil, tags: nil, version: nil}

  def fixture(:service) do
    {:ok, service} = Project.create_service(@create_attrs)
    service
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all services", %{conn: conn} do
      conn = get(conn, Routes.service_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create service" do
    test "renders service when data is valid", %{conn: conn} do
      conn = post(conn, Routes.service_path(conn, :create), service: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.service_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some author",
               "config" => "some config",
               "description" => "some description",
               "name" => "some name",
               "tags" => [],
               "version" => "some version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.service_path(conn, :create), service: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update service" do
    setup [:create_service]

    test "renders service when data is valid", %{conn: conn, service: %Service{id: id} = service} do
      conn = put(conn, Routes.service_path(conn, :update, service), service: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.service_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some updated author",
               "config" => "some updated config",
               "description" => "some updated description",
               "name" => "some updated name",
               "tags" => [],
               "version" => "some updated version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, service: service} do
      conn = put(conn, Routes.service_path(conn, :update, service), service: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete service" do
    setup [:create_service]

    test "deletes chosen service", %{conn: conn, service: service} do
      conn = delete(conn, Routes.service_path(conn, :delete, service))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.service_path(conn, :show, service))
      end
    end
  end

  defp create_service(_) do
    service = fixture(:service)
    %{service: service}
  end
end
