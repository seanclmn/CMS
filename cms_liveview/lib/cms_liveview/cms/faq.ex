defmodule CmsLiveview.Cms.Faq do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Flop.Schema,
    filterable: [:question, :answer],
    sortable: [:position],
    default_order: %{
      order_by: [:position],
      order_directions: [:asc]
    }
  }

  schema "faqs" do
    field :question, :string
    field :answer, :string
    field :position, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer, :position])
    |> validate_required([:question, :answer])
  end

end
