defmodule Welcome.ATSTest do
  use Welcome.DataCase

  import Welcome.Factory

  alias Welcome.ATS
  alias Welcome.ATS.{Applicant, Stage, Application}

  test "create_applicant/1 with valid data creates an applicant record" do
    assert {:ok, %Applicant{}} = ATS.create_applicant(%{name: "Pierre", title: "Developer"})
  end

  test "create_applicant/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ATS.create_applicant(%{name: ""})
  end

  test "create_stage/1 with valid data creates an stage record" do
    assert {:ok, %Stage{}} = ATS.create_stage(%{name: "Meet up", position: 0})
  end

  test "create_stage/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = ATS.create_stage(%{name: ""})
  end

  test "list_stages/1 returns all stages for a job offer and their applicants" do
    insert!(:stage, name: "Meet up", position: 0)
    insert!(:stage, name: "Interview", position: 1)
    stages = ATS.list_stages() |> Enum.map(& &1.name)
    assert stages == ["Meet up", "Interview"]
  end

  describe "applications positionning" do
    setup do
      applicants = %{
        pierre: insert!(:pierre),
        george: insert!(:george),
        john: insert!(:john),
        mary: insert!(:mary)
      }

      stages = %{
        meet_up: insert!(:stage, name: "Meet up", position: 0),
        interview: insert!(:stage, name: "Interview", position: 1)
      }

      {:ok, applicants: applicants, stages: stages}
    end

    test "links an applicant to a job offer and at first stage of recruitment", %{
      applicants: applicants,
      stages: stages
    } do
      assert {:ok, %Application{} = application} = ATS.create_application(applicants.pierre)
      assert application.applicant_id == applicants.pierre.id
      assert application.stage_id == stages.meet_up.id
      assert application.position == 0
    end

    test "Move an application from one stage to another", %{
      applicants: applicants,
      stages: stages
    } do
      {:ok, _pierre_application} = ATS.create_application(applicants.pierre)
      {:ok, george_application} = ATS.create_application(applicants.george)
      {:ok, _john_application} = ATS.create_application(applicants.john)

      ATS.update_application(george_application, %{stage_id: stages.interview.id, position: 0})

      meet_up_applicants =
        ATS.list_applicants_for_stage(stages.meet_up)
        |> Enum.map(& &1.name)

      interview_applicants =
        ATS.list_applicants_for_stage(stages.interview)
        |> Enum.map(& &1.name)

      assert meet_up_applicants == ["Pierre Hurtevent", "John Paul"]
      assert interview_applicants == ["George Abitbol"]
    end

    test "Cannot move an application to a stage with negative position", %{
      applicants: applicants
    } do
      {:ok, pierre_application} = ATS.create_application(applicants.pierre)

      {:error, _changeset} = ATS.update_application(pierre_application, %{position: -1})
    end

    # TODO: more positionning tests needed
  end
end
