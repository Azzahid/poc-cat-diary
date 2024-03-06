defmodule CatDiaryPoc.Schema.CatDiary.Diary do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  schema "diaries" do
    field :date, :date
    field :title, :string
    field :text, :string

    belongs_to :cat, Cat,
      references: :uuid,
      foreign_key: :cat_uuid,
      type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(diary, attrs) do
    diary
    |> cast(attrs, [
      :title,
      :text,
      :date,
      :cat_uuid
    ])
    |> validate_required([
      :title,
      :text,
      :date,
      :cat_uuid
    ])
  end
end
