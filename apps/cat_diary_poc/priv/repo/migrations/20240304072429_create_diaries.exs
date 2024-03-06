defmodule CatDiaryPoc.Repo.Migrations.CreateDiaries do
  use Ecto.Migration

  def change do
    create table(:diaries, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :title, :text
      add :text, :text
      add :date, :date
      add :cat, references(:cats, column: :uuid, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end
  end
end
