defmodule TigerApi.Repo.Migrations.CreateServices do
  use Ecto.Migration

  def change do
    create table(:services, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text
      add :tags, {:array, :string}
      add :config, :text
      add :version, :string
      add :author, :string

      timestamps()
    end

  end
end
