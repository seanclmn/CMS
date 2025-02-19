defmodule CmsLiveviewWeb.Components.Modal do
  use Phoenix.LiveComponent
  alias CmsLiveview.Cms.Faq
  import CmsLiveviewWeb.CoreComponents

  def update(assigns, socket) do
    changeset =
      %Faq{}
      |> Ecto.Changeset.cast(
        %{
          question: assigns[:question] || "",
          answer: assigns[:answer] || ""
        },
        [:question, :answer]
      )

    form = to_form(changeset)

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

  def handle_event("edit", faq_params, socket) do
    changeset = Faq.changeset(%Faq{}, faq_params)

    if changeset.valid? do
      case CmsLiveview.Cms.update_faq(faq_params) do
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
        {@title}
      </.button>
      <.modal id="modal-component">
        <.simple_form for={@form} phx-submit={@action} phx-target={@myself}>
          <.input type="text" name="question" label="New Question" field={@form[:question]} />
          <.input type="textarea" name="answer" label="New Answer" field={@form[:answer]} />
          <.button>{@title}</.button>
        </.simple_form>
      </.modal>
    </div>
    """
  end
end
