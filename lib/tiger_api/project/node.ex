defmodule TigerApi.Project.Node do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "nodes" do
    field :description, :string
    field :host, :string
    field :ip, :string
    field :name, :string
    field :password, :string
    field :ping, :naive_datetime
    field :port, :string
    field :status, :boolean, default: false
    field :username, :string
    field :region_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(node, attrs) do
    node
    |> cast(attrs, [:name, :description, :host, :ip, :port, :username, :password, :ping, :status])
    |> validate_required([
      :name,
      :description,
      :host,
      :ip,
      :port,
      :username,
      :password,
      :ping,
      :status
    ])
    |> unique_constraint(:name)
  end
end
