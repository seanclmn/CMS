defmodule CmsLiveviewWeb.Components.Modal do
  use Phoenix.LiveComponent
  alias CmsLiveview.Cms.Faq
  import CmsLiveviewWeb.CoreComponents

  def update(assigns, socket) do
    form = to_form(Faq.changeset(%Faq{}, %{}))

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:form, form)}
  end

  def handle_event("save", faq_params, socket) do
    changeset = Faq.changeset(%Faq{}, faq_params)

    if changeset.valid? do
      case CmsLiveview.Cms.create_faq(faq_params) do
        {:ok, faq} ->
          hide_modal("modal-component")
          {:noreply, socket}

        {:error, changeset} ->
          {:noreply, socket}
      end
    end
  end

  def render(assigns) do
    ~H"""
    <div>
      <.button
        phx-click={show_modal("modal-component")}
        phx-target={@myself}
        class="my-2">
        Add new FAQ
      </.button>
      <.modal id="modal-component">
        <.simple_form for={@form} phx-submit="save" phx-target={@myself}>
          <.input type="text" name="question" label="New Question" field={@form[:question]} />
          <.input type="textarea" name="answer" label="New Answer" field={@form[:answer]} />
          <.button>Submit</.button>
        </.simple_form>
      </.modal>
    </div>
    """
  end
end
