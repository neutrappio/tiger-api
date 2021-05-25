defmodule TigerApi.Repo do
  use Ecto.Repo,
    otp_app: :tiger_api,
    adapter: Ecto.Adapters.Postgres
end
