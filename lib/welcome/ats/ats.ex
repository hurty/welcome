defmodule Welcome.ATS do
  import Ecto.Query

  alias Welcome.Repo
  alias Welcome.ATS.{JobOffer, Applicant, Stage, Application}
  alias Welcome.Position

  def get_job_offer!() do
    %JobOffer{stages: list_stages(), applications: list_applications()}
  end

  def list_stages(_job_offer \\ nil) do
    applications_query =
      from a in Application,
        order_by: :position,
        preload: [:applicant]

    Stage
    |> order_by(:position)
    |> preload(applications: ^applications_query)
    |> Repo.all()
  end

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

  def list_applications() do
    Application
    |> preload(:applicant)
    |> Repo.all()
  end

  def get_application!(id) do
    Application
    |> preload(:applicant)
    |> Repo.get!(id)
  end

  # Link an applicant to a job offer, starting at the beginning of the recruitment pipeline.
  # In the context of this technical test, we assume there is only one job offer (= one board)
  def create_application(applicant, _job_offer \\ nil) do
    first_stage = get_job_offer_first_stage()

    applicant
    |> Ecto.build_assoc(:applications)
    |> Application.create_changeset(%{stage_id: first_stage.id})
    |> Position.insert_at_bottom(:stage_id, first_stage.id)
    |> Repo.insert()
  end

  def update_application(application, attrs) do
    application
    |> Application.update_changeset(attrs)
    |> Position.recompute_positions(:stage_id)
    |> Repo.update()
  end

  def list_applicants_for_stage(stage) do
    query =
      from apt in Applicant,
        join: apn in Application,
        on: apn.applicant_id == apt.id,
        where: apn.stage_id == ^stage.id,
        order_by: apn.position

    Repo.all(query)
  end

  # In the context of this technical test, we assume there is only one job offer (= one board)
  defp get_job_offer_first_stage(_jober_offer \\ nil) do
    Stage
    |> first(:position)
    |> Repo.one()
  end
end
