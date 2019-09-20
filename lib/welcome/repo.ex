defmodule Welcome.Repo do
  use Ecto.Repo,
    otp_app: :welcome,
    adapter: Ecto.Adapters.Postgres

  def reload(%module{id: id}) do
    get(module, id)
  end
end
