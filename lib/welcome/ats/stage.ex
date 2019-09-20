defmodule Welcome.ATS.Stage do
  use Ecto.Schema
  import Ecto.Changeset

  alias Welcome.ATS.Applicant

  schema "stages" do
    field :name, :string
    field :position, :integer
    timestamps()

    many_to_many(:applicants, Applicant, join_through: "applicants_stages")
  end

  @doc false
  def changeset(stage, attrs) do
    stage
    |> cast(attrs, [:name, :position])
    |> validate_required([:name, :position])
  end
end
