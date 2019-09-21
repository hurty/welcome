defmodule WelcomeWeb.JobOfferChannel do
  use Phoenix.Channel

  alias Welcome.ATS

  def join("job_offer:board", _message, socket) do
    {:ok, socket}
  end

  def handle_in("list_stages", _body, socket) do
    stages = ATS.list_stages()
    {:reply, {:ok, %{type: "list_stages", stages: stages}}, socket}
  end
end
