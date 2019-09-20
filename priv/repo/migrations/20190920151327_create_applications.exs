defmodule Welcome.Repo.Migrations.CreateApplications do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add(:stage_id, references(:stages, on_delete: :delete_all), null: false)
      add(:applicant_id, references(:applicants, on_delete: :delete_all), null: false)
      add :position, :integer, null: false
    end

    create(index(:applications, [:stage_id, :applicant_id], unique: true))
    create(index(:applications, :position))
  end
end
