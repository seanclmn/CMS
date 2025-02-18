defmodule CmsLiveview.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question, :string
      add :answer, :string

      timestamps(type: :utc_datetime)
    end
  end
end
