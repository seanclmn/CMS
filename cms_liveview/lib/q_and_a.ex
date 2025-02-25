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
    {:noreply, assign(socket, faqs: Cms.list_faqs())}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full p-4 flex flex-col items-center">
      <%= for faq <- assigns.faqs do %>
        <div class="flex flex-row justify-between items-end w-full px-4 pb-4 my-2 border-solid border-2 border-gray-200 rounded-lg max-w-xl">
          <div class="flex flex-col my-2">
            <p class="font-bold my-2"><span>Question:</span> {faq.question}</p>
            <p class="text-wrap"><span>Answer:</span> {faq.answer}</p>
          </div>
          <p>{faq.position}</p>
          <div class="flex items-start my-2">
            <.live_component
              module={CmsLiveviewWeb.Components.Modal}
              id={"modal-component-edit-#{faq.id}"}
              question_id={faq.id}
              question={faq.question}
              answer={faq.answer}
              action="edit"
              title="Edit"
            />
            <button
            phx-click="delete"
            phx-value-id={faq.id}
            class="flex flex-col justify-start"
            >
            <.icon
              name="hero-x-mark-solid"
              class="bg-sky-500 text-black cursor-pointer"
            />
            </button>
          </div>
        </div>
      <% end %>
      <.live_component
        module={CmsLiveviewWeb.Components.Modal}
        id="modal-component-save"
        title="Add new FAQ"
        action="save"
        question=""
        answer=""
      />
    </div>
    """
  end
end
