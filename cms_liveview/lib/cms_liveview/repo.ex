defmodule CmsLiveview.Repo do
  use Ecto.Repo,
    otp_app: :cms_liveview,
    adapter: Ecto.Adapters.Postgres
end
