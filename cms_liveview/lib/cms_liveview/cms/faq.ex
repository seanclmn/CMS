defmodule CmsLiveview.Cms.Faq do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :question, :string
    field :answer, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question, :answer])
    |> validate_required([:question, :answer])
  end
end
