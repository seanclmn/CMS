defmodule CmsLiveview.Repo.Migrations.AddOrdering do
  use Ecto.Migration

  def change do
    alter table(:faqs) do
      add :position, :integer, default: 0
    end

  end
end
