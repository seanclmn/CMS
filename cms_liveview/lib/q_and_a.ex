defmodule CmsLiveviewWeb.QA do
  use Phoenix.LiveView
  import CmsLiveviewWeb.CoreComponents
  alias CmsLiveview.Cms

  def mount(_params, _session, socket) do
    faqs = Cms.list_faqs()
    {:ok, assign(socket, faqs: faqs)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    Cms.delete_faq(id)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full p-4">
      <%= for faq <- assigns.faqs do %>
        <div class="flex flex-row  justify-between items-end w-full my-2">
          <div class="flex flex-col my-4">
            <p class="font-bold my-2"><span>Question:</span> {faq.question}</p>
            <p class="text-wrap"><span>Answer:</span> {faq.answer}</p>
          </div>

          <.button class="bg-sky-500 text-black" phx-click="delete" phx-value-id={faq.id}>
            Delete
          </.button>
        </div>
      <% end %>
      <.live_component
        module={CmsLiveviewWeb.Components.Modal}
        id="modal-component"
      />
    </div>
    """
  end
end
