defmodule Welcome.ATS do
  import Ecto.Query
  alias Welcome.Repo
  alias Welcome.ATS.{Applicant, Stage}

  def create_stage(attrs) do
    %Stage{}
    |> Stage.changeset(attrs)
    |> Repo.insert()
  end

  def create_applicant(attrs) do
    %Applicant{}
    |> Applicant.changeset(attrs)
    |> Repo.insert()
  end
end
