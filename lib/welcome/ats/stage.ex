defmodule Welcome.ATS.Stage do
  use Ecto.Schema
  import Ecto.Changeset

  alias Welcome.ATS.Application

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

defimpl Jason.Encoder, for: Welcome.ATS.Stage do
  def encode(value, opts) do
    value
    |> put_applications_ids
    |> Map.take([:id, :name, :applications_ids])
    |> Jason.Encode.map(opts)
  end

  defp put_applications_ids(map) do
    ids = Enum.map(Map.get(map, :applications), & &1.id)
    Map.put(map, :applications_ids, ids)
  end
end
