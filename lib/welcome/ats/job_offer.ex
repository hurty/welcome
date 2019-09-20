defmodule Welcome.ATS.JobOffer do
  # We don't really need this for the test as we just need one board,
  # but we would have something like :
  #
  # has_many :stages, Stage
  # has_many :applicants, through: [:stages, :applicants]
end
