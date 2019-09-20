defmodule Welcome.ATS.Application do
  use Ecto.Schema
  import Ecto.Changeset

  alias Welcome.ATS.{Applicant, Stage}

  schema "applications" do
    belongs_to(:applicant, Applicant)
    belongs_to(:stage, Applicant)
    field(:position, :integer)
  end

  def changeset(application, attrs) do
    application
    |> cast(attrs, [:stage_id, :applicant_id, :position])
    |> validate_required([:stage_id, :applicant_id])
  end
end
