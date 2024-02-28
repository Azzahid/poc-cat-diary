defmodule CatDiaryPoc.Repo do
  use Ecto.Repo,
    otp_app: :cat_diary_poc,
    adapter: Ecto.Adapters.Postgres
end
