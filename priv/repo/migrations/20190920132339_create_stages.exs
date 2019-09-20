defmodule Welcome.Repo.Migrations.CreateStages do
  use Ecto.Migration

  def change do
    create table(:stages) do
      add :name, :string
      add :position, :integer, null: false
      timestamps()
    end

    create(index(:stages, :position))

    create table(:applicants_stages) do
      add(:stage_id, references(:stages, on_delete: :delete_all), null: false)
      add(:applicant_id, references(:applicants, on_delete: :delete_all), null: false)
      add :position, :integer, null: false
    end

    create(index(:applicants_stages, [:stage_id, :applicant_id], unique: true))
    create(index(:applicants_stages, :position))
  end
end
