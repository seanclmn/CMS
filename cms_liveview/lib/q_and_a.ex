defmodule CmsLiveviewWeb.QA do
  use Phoenix.LiveView

  alias CmsLiveview.Cms

  def mount(_params, _session, socket) do
    faqs = Cms.list_faqs()
    IO.inspect(faqs)
    {:ok, assign(socket, faqs: faqs)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Modal Page</h1>
      <.live_component module={CmsLiveviewWeb.Components.Modal} id="modal-component" />
      <ul>
        <p>wonton</p>
        <%= for faq <- assigns.faqs do %>
          <div>
            <li><%= faq.question %></li>
            <li><%= faq.answer %></li>
            </div>
        <% end %>
      </ul>
    </div>
    """
  end
end
