defmodule CmsLiveviewWeb.Components.Modal do
  use Phoenix.LiveComponent
  alias CmsLiveview.Cms.Faq
  import CmsLiveviewWeb.CoreComponents

  def update(assigns, socket) do
    IO.inspect("hello")
    form = to_form(Faq.changeset(%Faq{}, %{}))
    {:ok, assign(socket, assigns |> Map.put(:form, form))}
  end

  def handle_event("save", faq_params, socket) do
    changeset = Faq.changeset(%Faq{}, faq_params)

    if changeset.valid? do
      case CmsLiveview.Cms.create_faq(faq_params) do
        {:ok, faq} ->
          {:noreply, socket}

        {:error, changeset} ->
          {:noreply, socket}
      end
    end
  end

  def render(assigns) do
    ~H"""
    <div>
    <button>
    open  modal
    </button>
    <.modal id="modal-component" show={true}>
      <.simple_form for={@form} phx-submit="save" phx-target={@myself}>
        <.input type="text" name="question" field={@form[:question]} />
        <.input type="text" name="answer" field={@form[:answer]} />
        <.button>Submit</.button>
      </.simple_form>
    </.modal>
    </div>
    """
  end
end
