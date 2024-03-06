defmodule CatDiaryPoc.Repo.Migrations.CreateCats do
  use Ecto.Migration

  def change do
    create table(:cats, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :name, :string
      add :birth_date, :date
      add :description, :string

      timestamps()
    end
  end
end
