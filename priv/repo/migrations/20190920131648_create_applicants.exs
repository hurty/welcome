defmodule Welcome.Repo.Migrations.CreateApplicants do
  use Ecto.Migration

  def change do
    create table(:applicants) do
      add :name, :string
      add :title, :string

      timestamps()
    end

  end
end
