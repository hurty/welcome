defmodule Welcome.ATS.Applicant do
  use Ecto.Schema
  import Ecto.Changeset

  alias Welcome.ATS.Stage

  schema "applicants" do
    field :name, :string
    field :title, :string
    field :position, :integer
    timestamps()

    many_to_many(:stages, Stage, join_through: "applicants_stages")
  end

  @doc false
  def changeset(applicant, attrs) do
    applicant
    |> cast(attrs, [:name, :title])
    |> validate_required([:name])
  end
end
