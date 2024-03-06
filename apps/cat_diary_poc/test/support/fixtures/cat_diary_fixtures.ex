defmodule CatDiaryPoc.CatDiaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CatDiaryPoc.CatDiary` context.
  """

  @doc """
  Generate a diary.
  """
  def diary_fixture(attrs \\ %{}) do
    {:ok, diary} =
      attrs
      |> Enum.into(%{
        cat: "some cat",
        date: ~D[2024-03-03],
        text: "some text",
        title: "some title"
      })
      |> CatDiaryPoc.CatDiary.create_diary()

    diary
  end

  @doc """
  Generate a cat.
  """
  def cat_fixture(attrs \\ %{}) do
    {:ok, cat} =
      attrs
      |> Enum.into(%{
        birth_date: ~D[2024-03-03],
        description: "some description",
        name: "some name"
      })
      |> CatDiaryPoc.CatDiary.create_cat()

    cat
  end
end
