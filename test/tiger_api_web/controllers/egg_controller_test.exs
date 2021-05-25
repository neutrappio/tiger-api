defmodule TigerApiWeb.EggControllerTest do
  use TigerApiWeb.ConnCase

  alias TigerApi.Project
  alias TigerApi.Project.Egg

  @create_attrs %{
    author: "some author",
    config: "some config",
    description: "some description",
    logo: "some logo",
    name: "some name",
    releasedate: "2010-04-17T14:00:00Z",
    tags: [],
    title: "some title",
    version: "some version"
  }
  @update_attrs %{
    author: "some updated author",
    config: "some updated config",
    description: "some updated description",
    logo: "some updated logo",
    name: "some updated name",
    releasedate: "2011-05-18T15:01:01Z",
    tags: [],
    title: "some updated title",
    version: "some updated version"
  }
  @invalid_attrs %{
    author: nil,
    config: nil,
    description: nil,
    logo: nil,
    name: nil,
    releasedate: nil,
    tags: nil,
    title: nil,
    version: nil
  }

  def fixture(:egg) do
    {:ok, egg} = Project.create_egg(@create_attrs)
    egg
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all eggs", %{conn: conn} do
      conn = get(conn, Routes.egg_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create egg" do
    test "renders egg when data is valid", %{conn: conn} do
      conn = post(conn, Routes.egg_path(conn, :create), egg: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.egg_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some author",
               "config" => "some config",
               "description" => "some description",
               "logo" => "some logo",
               "name" => "some name",
               "releasedate" => "2010-04-17T14:00:00Z",
               "tags" => [],
               "title" => "some title",
               "version" => "some version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.egg_path(conn, :create), egg: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update egg" do
    setup [:create_egg]

    test "renders egg when data is valid", %{conn: conn, egg: %Egg{id: id} = egg} do
      conn = put(conn, Routes.egg_path(conn, :update, egg), egg: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.egg_path(conn, :show, id))

      assert %{
               "id" => id,
               "author" => "some updated author",
               "config" => "some updated config",
               "description" => "some updated description",
               "logo" => "some updated logo",
               "name" => "some updated name",
               "releasedate" => "2011-05-18T15:01:01Z",
               "tags" => [],
               "title" => "some updated title",
               "version" => "some updated version"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, egg: egg} do
      conn = put(conn, Routes.egg_path(conn, :update, egg), egg: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete egg" do
    setup [:create_egg]

    test "deletes chosen egg", %{conn: conn, egg: egg} do
      conn = delete(conn, Routes.egg_path(conn, :delete, egg))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.egg_path(conn, :show, egg))
      end
    end
  end

  defp create_egg(_) do
    egg = fixture(:egg)
    %{egg: egg}
  end
end
