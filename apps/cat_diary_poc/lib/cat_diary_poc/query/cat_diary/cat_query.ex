defmodule CatDiaryPoc.Query.CatDiary.CatQuery do
  use Ecto.Schema
  import Ecto.Query, warn: false
  alias CatDiaryPoc.Repo

  alias CatDiaryPoc.Schema.CatDiary.Cat
  def get_cat(), do: from(c in Cat, as: :cat)

  def with_uuid(query, uuid), do: query |> where(uuid: uuid)

  def with_name_like(query, name), do: query |> where([cat: c], ilike(c.name, (name)))

  def get_one(query) do
    query |> Repo.one()
  end

  def get_all(query) do
    query |> Repo.all()
  end
end
