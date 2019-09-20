defmodule Welcome.Factory do
  alias Welcome.Repo
  alias Welcome.ATS.{Applicant, Stage}

  def build(factory_name, attrs) do
    build(factory_name) |> struct(attrs)
  end

  def insert!(factory_name, attrs \\ []) do
    build(factory_name, attrs)
    |> Repo.insert!()
  end

  # --- APPLICANTS

  def build(:pierre) do
    %Applicant{
      name: "Pierre Hurtevent",
      title: "Developer"
    }
  end

  def build(:john) do
    %Applicant{
      name: "John Paul",
      title: "Astronaut"
    }
  end

  def build(:george) do
    %Applicant{
      name: "George Abitbol",
      title: "The most classy man on earth"
    }
  end

  def build(:mary) do
    %Applicant{
      name: "Mary Pouet",
      title: "Pianist"
    }
  end

  # --- STAGES

  def build(:stage) do
    %Stage{name: "Meet up", position: 0}
  end
end
