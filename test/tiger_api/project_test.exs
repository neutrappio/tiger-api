defmodule TigerApi.ProjectTest do
  use TigerApi.DataCase

  alias TigerApi.Project

  describe "regions" do
    alias TigerApi.Project.Region

    @valid_attrs %{
      continent: "some continent",
      description: "some description",
      name: "some name",
      status: true
    }
    @update_attrs %{
      continent: "some updated continent",
      description: "some updated description",
      name: "some updated name",
      status: false
    }
    @invalid_attrs %{continent: nil, description: nil, name: nil, status: nil}

    def region_fixture(attrs \\ %{}) do
      {:ok, region} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Project.create_region()

      region
    end

    test "list_regions/0 returns all regions" do
      region = region_fixture()
      assert Project.list_regions() == [region]
    end

    test "get_region!/1 returns the region with given id" do
      region = region_fixture()
      assert Project.get_region!(region.id) == region
    end

    test "create_region/1 with valid data creates a region" do
      assert {:ok, %Region{} = region} = Project.create_region(@valid_attrs)
      assert region.continent == "some continent"
      assert region.description == "some description"
      assert region.name == "some name"
      assert region.status == true
    end

    test "create_region/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Project.create_region(@invalid_attrs)
    end

    test "update_region/2 with valid data updates the region" do
      region = region_fixture()
      assert {:ok, %Region{} = region} = Project.update_region(region, @update_attrs)
      assert region.continent == "some updated continent"
      assert region.description == "some updated description"
      assert region.name == "some updated name"
      assert region.status == false
    end

    test "update_region/2 with invalid data returns error changeset" do
      region = region_fixture()
      assert {:error, %Ecto.Changeset{}} = Project.update_region(region, @invalid_attrs)
      assert region == Project.get_region!(region.id)
    end

    test "delete_region/1 deletes the region" do
      region = region_fixture()
      assert {:ok, %Region{}} = Project.delete_region(region)
      assert_raise Ecto.NoResultsError, fn -> Project.get_region!(region.id) end
    end

    test "change_region/1 returns a region changeset" do
      region = region_fixture()
      assert %Ecto.Changeset{} = Project.change_region(region)
    end
  end

  describe "nodes" do
    alias TigerApi.Project.Node

    @valid_attrs %{
      description: "some description",
      host: "some host",
      ip: "some ip",
      name: "some name",
      password: "some password",
      ping: ~N[2010-04-17 14:00:00],
      port: "some port",
      status: true,
      username: "some username"
    }
    @update_attrs %{
      description: "some updated description",
      host: "some updated host",
      ip: "some updated ip",
      name: "some updated name",
      password: "some updated password",
      ping: ~N[2011-05-18 15:01:01],
      port: "some updated port",
      status: false,
      username: "some updated username"
    }
    @invalid_attrs %{
      description: nil,
      host: nil,
      ip: nil,
      name: nil,
      password: nil,
      ping: nil,
      port: nil,
      status: nil,
      username: nil
    }

    def node_fixture(attrs \\ %{}) do
      {:ok, node} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Project.create_node()

      node
    end

    test "list_nodes/0 returns all nodes" do
      node = node_fixture()
      assert Project.list_nodes() == [node]
    end

    test "get_node!/1 returns the node with given id" do
      node = node_fixture()
      assert Project.get_node!(node.id) == node
    end

    test "create_node/1 with valid data creates a node" do
      assert {:ok, %Node{} = node} = Project.create_node(@valid_attrs)
      assert node.description == "some description"
      assert node.host == "some host"
      assert node.ip == "some ip"
      assert node.name == "some name"
      assert node.password == "some password"
      assert node.ping == ~N[2010-04-17 14:00:00]
      assert node.port == "some port"
      assert node.status == true
      assert node.username == "some username"
    end

    test "create_node/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Project.create_node(@invalid_attrs)
    end

    test "update_node/2 with valid data updates the node" do
      node = node_fixture()
      assert {:ok, %Node{} = node} = Project.update_node(node, @update_attrs)
      assert node.description == "some updated description"
      assert node.host == "some updated host"
      assert node.ip == "some updated ip"
      assert node.name == "some updated name"
      assert node.password == "some updated password"
      assert node.ping == ~N[2011-05-18 15:01:01]
      assert node.port == "some updated port"
      assert node.status == false
      assert node.username == "some updated username"
    end

    test "update_node/2 with invalid data returns error changeset" do
      node = node_fixture()
      assert {:error, %Ecto.Changeset{}} = Project.update_node(node, @invalid_attrs)
      assert node == Project.get_node!(node.id)
    end

    test "delete_node/1 deletes the node" do
      node = node_fixture()
      assert {:ok, %Node{}} = Project.delete_node(node)
      assert_raise Ecto.NoResultsError, fn -> Project.get_node!(node.id) end
    end

    test "change_node/1 returns a node changeset" do
      node = node_fixture()
      assert %Ecto.Changeset{} = Project.change_node(node)
    end
  end

  describe "eggs" do
    alias TigerApi.Project.Egg

    @valid_attrs %{
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

    def egg_fixture(attrs \\ %{}) do
      {:ok, egg} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Project.create_egg()

      egg
    end

    test "list_eggs/0 returns all eggs" do
      egg = egg_fixture()
      assert Project.list_eggs() == [egg]
    end

    test "get_egg!/1 returns the egg with given id" do
      egg = egg_fixture()
      assert Project.get_egg!(egg.id) == egg
    end

    test "create_egg/1 with valid data creates a egg" do
      assert {:ok, %Egg{} = egg} = Project.create_egg(@valid_attrs)
      assert egg.author == "some author"
      assert egg.config == "some config"
      assert egg.description == "some description"
      assert egg.logo == "some logo"
      assert egg.name == "some name"
      assert egg.releasedate == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert egg.tags == []
      assert egg.title == "some title"
      assert egg.version == "some version"
    end

    test "create_egg/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Project.create_egg(@invalid_attrs)
    end

    test "update_egg/2 with valid data updates the egg" do
      egg = egg_fixture()
      assert {:ok, %Egg{} = egg} = Project.update_egg(egg, @update_attrs)
      assert egg.author == "some updated author"
      assert egg.config == "some updated config"
      assert egg.description == "some updated description"
      assert egg.logo == "some updated logo"
      assert egg.name == "some updated name"
      assert egg.releasedate == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert egg.tags == []
      assert egg.title == "some updated title"
      assert egg.version == "some updated version"
    end

    test "update_egg/2 with invalid data returns error changeset" do
      egg = egg_fixture()
      assert {:error, %Ecto.Changeset{}} = Project.update_egg(egg, @invalid_attrs)
      assert egg == Project.get_egg!(egg.id)
    end

    test "delete_egg/1 deletes the egg" do
      egg = egg_fixture()
      assert {:ok, %Egg{}} = Project.delete_egg(egg)
      assert_raise Ecto.NoResultsError, fn -> Project.get_egg!(egg.id) end
    end

    test "change_egg/1 returns a egg changeset" do
      egg = egg_fixture()
      assert %Ecto.Changeset{} = Project.change_egg(egg)
    end
  end

  describe "services" do
    alias TigerApi.Project.Service

    @valid_attrs %{author: "some author", config: "some config", description: "some description", name: "some name", tags: [], version: "some version"}
    @update_attrs %{author: "some updated author", config: "some updated config", description: "some updated description", name: "some updated name", tags: [], version: "some updated version"}
    @invalid_attrs %{author: nil, config: nil, description: nil, name: nil, tags: nil, version: nil}

    def service_fixture(attrs \\ %{}) do
      {:ok, service} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Project.create_service()

      service
    end

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Project.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Project.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      assert {:ok, %Service{} = service} = Project.create_service(@valid_attrs)
      assert service.author == "some author"
      assert service.config == "some config"
      assert service.description == "some description"
      assert service.name == "some name"
      assert service.tags == []
      assert service.version == "some version"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Project.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()
      assert {:ok, %Service{} = service} = Project.update_service(service, @update_attrs)
      assert service.author == "some updated author"
      assert service.config == "some updated config"
      assert service.description == "some updated description"
      assert service.name == "some updated name"
      assert service.tags == []
      assert service.version == "some updated version"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Project.update_service(service, @invalid_attrs)
      assert service == Project.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Project.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Project.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Project.change_service(service)
    end
  end
end
