defmodule WelcomeWeb.JobOfferChannel do
  use Phoenix.Channel

  alias Welcome.ATS

  def join("job_offer:board", _message, socket) do
    {:ok, socket}
  end

  def handle_in("get_job_offer" = msg, _body, socket) do
    job_offer = ATS.get_job_offer!()
    {:reply, {:ok, %{type: msg, job_offer: job_offer}}, socket}
  end

  def handle_in("update_application", %{"application" => application_attrs}, socket) do
    application = ATS.get_application!(application_attrs["id"])
    old_stage_id = application.stage_id
    old_position = application.position

    # TODO: we can handle user authorization here

    case ATS.update_application(application, application_attrs) do
      {:ok, updated_application} ->
        broadcast!(socket, "update_application_position", %{
          application_id: updated_application.id,
          old_stage_id: old_stage_id,
          old_position: old_position,
          new_stage_id: updated_application.stage_id,
          new_position: updated_application.position
        })

        {:noreply, socket}

      {:error, changeset} ->
        {:reply, {:error, %{message: changeset.message}, socket}}
    end
  end
end
