defmodule TigerApi.Repo.Migrations.CreateNodes do
  use Ecto.Migration

  def change do
    create table(:nodes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text
      add :host, :string
      add :ip, :string
      add :port, :string
      add :username, :string
      add :password, :string
      add :ping, :naive_datetime
      add :status, :boolean, default: false, null: false
      add :region_id, references(:regions, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:nodes, [:name])
    create index(:nodes, [:region_id])
  end
end
