defmodule CmsLiveviewWeb.QA do
  use Phoenix.LiveView
  import CmsLiveviewWeb.CoreComponents
  alias CmsLiveview.Cms

  def mount(_params, _session, socket) do
    faqs = Cms.list_faqs()
    {:ok, assign(socket, faqs: faqs, action: "save")}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    Cms.delete_faq(id)
    {:noreply, assign(socket, faqs: Cms.list_faqs())}
  end

  def handle_event("edit", %{"id" => id}, socket) do
    Cms.update_faq(id)
    {:noreply, assign(socket, faqs: Cms.list_faqs())}
  end

  def handle_event("save", %{"question" => question, "answer" => answer}, socket) do
    Cms.create_faq(%{question: question, answer: answer})
    {:noreply, assign(socket, faqs: Cms.list_faqs())}
  end

  def render(assigns) do
    ~H"""
    <div class="w-full p-4">
      <%= for faq <- assigns.faqs do %>
        <div class="flex flex-row  justify-between items-end w-full py-2 my-2 border-solid border-b-2 border-gray-200">
          <div class="flex flex-col my-4">
            <p class="font-bold my-2"><span>Question:</span> {faq.question}</p>
            <p class="text-wrap"><span>Answer:</span> {faq.answer}</p>
          </div>
          <div class="flex items-start">
            <.live_component
              module={CmsLiveviewWeb.Components.Modal}
              id={"modal-component-edit-#{faq.id}"}
              question_id={faq.id}
              question={faq.question}
              answer={faq.answer}
              action="edit"
              title="Edit"
            />
            <.button
              class="bg-sky-500 text-black"
              phx-click="delete"
              phx-value-id={faq.id}
            >
              Delete
            </.button>
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
