defmodule TigerApi.Project.Egg do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "eggs" do
    field :author, :string
    field :config, :string
    field :description, :string
    field :logo, :string
    field :name, :string
    field :releasedate, :utc_datetime
    field :tags, {:array, :string}
    field :title, :string
    field :version, :string

    timestamps()
  end

  @doc false
  def changeset(egg, attrs) do
    egg
    |> cast(attrs, [
      :name,
      :title,
      :logo,
      :description,
      :tags,
      :config,
      :version,
      :releasedate,
      :author
    ])
    |> validate_required([
      :name,
      :title,
      :logo,
      :description,
      :tags,
      :config,
      :version,
      :releasedate,
      :author
    ])
  end
end
