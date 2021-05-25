defmodule TigerApi.Project.Region do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "regions" do
    field :continent, :string
    field :description, :string, default: ""
    field :name, :string
    field :status, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(region, attrs) do
    region
    |> cast(attrs, [:name, :continent, :description, :status])
    |> validate_required([:name, :continent, :status])
    |> unique_constraint(:name)
  end
end
