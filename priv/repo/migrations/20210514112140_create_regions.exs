defmodule TigerApi.Repo.Migrations.CreateRegions do
  use Ecto.Migration

  def change do
    create table(:regions, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :name, :string
      add :continent, :string, default: "", null: true
      add :description, :text
      add :status, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:regions, [:name])
  end
end
