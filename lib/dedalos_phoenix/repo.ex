defmodule DedalosPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :dedalos_phoenix,
    adapter: Ecto.Adapters.Postgres
end
