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
    case CmsLiveview.Cms.create_faq(faq_params) do
      {:ok, faq} ->
        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, socket}
    end
  end

  def handle_event("edit", faq_params, socket) do
    case CmsLiveview.Cms.update_faq(faq_params) do
      {:ok, faq} ->
        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div>
      <.button
        phx-click={show_modal(@id)}
        phx-target={@myself}
        class="my-2">
        {@title}
      </.button>
      <.modal id={@id}>
        <.simple_form for={@form} phx-submit={@action} phx-target={@myself}>
          <.input type="text" name="question" label="New Question" field={@form[:question]} value={@question} />
          <.input type="textarea" name="answer" label="New Answer" field={@form[:answer]} value={@answer} />
          <.button>{@title}</.button>
        </.simple_form>
      </.modal>
    </div>
    """
  end
end
