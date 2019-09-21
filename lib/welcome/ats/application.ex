defmodule Welcome.ATS.Application do
  use Ecto.Schema
  import Ecto.Changeset

  alias Welcome.ATS.{Applicant, Stage}

  @derive {Jason.Encoder, only: [:id, :applicant]}

  schema "applications" do
    belongs_to(:applicant, Applicant)
    belongs_to(:stage, Stage)
    field(:position, :integer)
  end

  def create_changeset(application, attrs) do
    application
    |> cast(attrs, [:stage_id, :applicant_id, :position])
    |> validate_required([:stage_id, :applicant_id])
  end

  def update_changeset(application, attrs) do
    application
    |> cast(attrs, [:stage_id, :position])
    |> validate_required([:stage_id, :position])
  end
end
