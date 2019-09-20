defmodule Welcome.ATSTest do
  use Welcome.DataCase

  alias Welcome.ATS
  alias Welcome.ATS.{Applicant, Stage}

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
end
