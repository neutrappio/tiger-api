defmodule TigerApi.Project.Service do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "services" do
    field :author, :string
    field :config, :string
    field :description, :string
    field :name, :string
    field :tags, {:array, :string}
    field :version, :string

    timestamps()
  end

  @doc false
  def changeset(service, attrs) do
    service
    |> cast(attrs, [:name, :description, :tags, :config, :version, :author])
    |> validate_required([:name, :description, :tags, :config, :version, :author])
  end
end
