defmodule TigerApi.Repo.Migrations.CreateEggs do
  use Ecto.Migration

  def change do
    create table(:eggs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :title, :string
      add :logo, :text
      add :description, :text
      add :tags, {:array, :string}
      add :config, :text
      add :version, :string
      add :releasedate, :utc_datetime
      add :author, :string

      timestamps()
    end
  end
end
