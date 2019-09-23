defmodule WelcomeWeb.BoardLive do
  use Phoenix.LiveView

  alias Welcome.ATS

  def render(assigns) do
    ~L"""
    <section class="board" phx-hook="Board">
      <%= for stage <- @job_offer.stages do %>
        <div class="list">
          <div class="list__header">
            <div class="list__name"><%= stage.name %></div>
            <div class="list__counter"><%= length(stage.applications) %></div>
          </div>

          <ul data-stage-id="<%= stage.id %>" class="list__cards">
            <%= for application <- stage.applications do %>
              <li data-application-id="<%= application.id %>" class="card">
                <div class="applicant__name"><%= application.applicant.name %></div>
                <div class="applicant__info"><%= application.applicant.title %></div>
              </li>
            <% end %>
          </ul>
        </div>
      <% end %>
    </section>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: ATS.subscribe()
    {:ok, assign(socket, :job_offer, ATS.get_job_offer!())}
  end

  def handle_event("update_application", %{"application" => application_attrs}, socket) do
    application = ATS.get_application!(application_attrs["id"])

    case ATS.update_application(application, application_attrs) do
      {:ok, _updated_application} ->
        {:noreply, update(socket, :job_offer, fn _ -> ATS.get_job_offer!() end)}

      {:error, changeset} ->
        {:noreply, {:error, %{message: changeset.message}, socket}}
    end
  end

  def handle_info({ATS, [:application, :updated], _}, socket) do
    {:noreply, assign(socket, :job_offer, ATS.get_job_offer!())}
  end
end
