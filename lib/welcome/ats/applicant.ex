defmodule Welcome.ATS.Applicant do
  use Ecto.Schema
  import Ecto.Changeset

  alias Welcome.ATS.{Application}

  @derive {Jason.Encoder, only: [:id, :name, :title]}

  schema "applicants" do
    field :name, :string
    field :title, :string
    timestamps()

    has_many(:applications, Application)
    has_many(:stages, through: [:applications, :stage])
  end

  @doc false
  def changeset(applicant, attrs) do
    applicant
    |> cast(attrs, [:name, :title])
    |> validate_required([:name])
  end
end
