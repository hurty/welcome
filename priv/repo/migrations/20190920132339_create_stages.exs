defmodule Welcome.Repo.Migrations.CreateStages do
  use Ecto.Migration

  def change do
    create table(:stages) do
      add :name, :string
      add :position, :integer, null: false
      timestamps()
    end

    create(index(:stages, :position))
  end
end
