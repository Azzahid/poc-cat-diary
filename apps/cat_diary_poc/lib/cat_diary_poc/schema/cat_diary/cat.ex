defmodule CatDiaryPoc.Schema.CatDiary.Cat do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}
  schema "cats" do
    field :name, :string
    field :description, :string
    field :birth_date, :date

    timestamps()
  end

  @doc false
  def changeset(cat, attrs) do
    cat
    |> cast(attrs, [:name, :birth_date, :description])
    |> validate_required([:name, :birth_date, :description])
  end
end
