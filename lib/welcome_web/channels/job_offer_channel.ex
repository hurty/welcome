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

  def handle_in("update_application", %{"application" => application_attrs}, socket) do
    application = ATS.get_application!(application_attrs["id"])

    # TODO: we can handle user authorization here

    case ATS.update_application(application, application_attrs) do
      {:ok, _application} -> {:noreply, socket}
      {:error, changeset} -> {:reply, {:error, %{message: changeset.message}, socket}}
    end
  end
end
