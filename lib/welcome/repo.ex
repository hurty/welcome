defmodule Welcome.Repo do
  use Ecto.Repo,
    otp_app: :welcome,
    adapter: Ecto.Adapters.Postgres
end
