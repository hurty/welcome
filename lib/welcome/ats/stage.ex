defmodule Welcome.ATS.Stage do
  use Ecto.Schema
  import Ecto.Changeset

  alias Welcome.ATS.Application

  @derive {Jason.Encoder, only: [:id, :name, :position, :applications]}

  schema "stages" do
    field :name, :string
    field :position, :integer
    timestamps()
    has_many(:applications, Application)
    has_many(:applicants, through: [:applications, :applicant])
  end

  @doc false
  def changeset(stage, attrs) do
    stage
    |> cast(attrs, [:name, :position])
    |> validate_required([:name, :position])
  end
end
