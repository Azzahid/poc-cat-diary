defmodule CatDiaryPoc.CatDiaryTest do
  use CatDiaryPoc.DataCase

  alias CatDiaryPoc.CatDiary

  describe "diaries" do
    alias CatDiaryPoc.CatDiary.Diary

    import CatDiaryPoc.CatDiaryFixtures

    @invalid_attrs %{date: nil, title: nil, cat: nil, text: nil}

    test "list_diaries/0 returns all diaries" do
      diary = diary_fixture()
      assert CatDiary.list_diaries() == [diary]
    end

    test "get_diary!/1 returns the diary with given id" do
      diary = diary_fixture()
      assert CatDiary.get_diary!(diary.id) == diary
    end

    test "create_diary/1 with valid data creates a diary" do
      valid_attrs = %{date: ~D[2024-03-03], title: "some title", cat: "some cat", text: "some text"}

      assert {:ok, %Diary{} = diary} = CatDiary.create_diary(valid_attrs)
      assert diary.date == ~D[2024-03-03]
      assert diary.title == "some title"
      assert diary.cat == "some cat"
      assert diary.text == "some text"
    end

    test "create_diary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CatDiary.create_diary(@invalid_attrs)
    end

    test "update_diary/2 with valid data updates the diary" do
      diary = diary_fixture()
      update_attrs = %{date: ~D[2024-03-04], title: "some updated title", cat: "some updated cat", text: "some updated text"}

      assert {:ok, %Diary{} = diary} = CatDiary.update_diary(diary, update_attrs)
      assert diary.date == ~D[2024-03-04]
      assert diary.title == "some updated title"
      assert diary.cat == "some updated cat"
      assert diary.text == "some updated text"
    end

    test "update_diary/2 with invalid data returns error changeset" do
      diary = diary_fixture()
      assert {:error, %Ecto.Changeset{}} = CatDiary.update_diary(diary, @invalid_attrs)
      assert diary == CatDiary.get_diary!(diary.id)
    end

    test "delete_diary/1 deletes the diary" do
      diary = diary_fixture()
      assert {:ok, %Diary{}} = CatDiary.delete_diary(diary)
      assert_raise Ecto.NoResultsError, fn -> CatDiary.get_diary!(diary.id) end
    end

    test "change_diary/1 returns a diary changeset" do
      diary = diary_fixture()
      assert %Ecto.Changeset{} = CatDiary.change_diary(diary)
    end
  end

  describe "cats" do
    alias CatDiaryPoc.CatDiary.Cat

    import CatDiaryPoc.CatDiaryFixtures

    @invalid_attrs %{name: nil, description: nil, birth_date: nil}

    test "list_cats/0 returns all cats" do
      cat = cat_fixture()
      assert CatDiary.list_cats() == [cat]
    end

    test "get_cat!/1 returns the cat with given id" do
      cat = cat_fixture()
      assert CatDiary.get_cat!(cat.id) == cat
    end

    test "create_cat/1 with valid data creates a cat" do
      valid_attrs = %{name: "some name", description: "some description", birth_date: ~D[2024-03-03]}

      assert {:ok, %Cat{} = cat} = CatDiary.create_cat(valid_attrs)
      assert cat.name == "some name"
      assert cat.description == "some description"
      assert cat.birth_date == ~D[2024-03-03]
    end

    test "create_cat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CatDiary.create_cat(@invalid_attrs)
    end

    test "update_cat/2 with valid data updates the cat" do
      cat = cat_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", birth_date: ~D[2024-03-04]}

      assert {:ok, %Cat{} = cat} = CatDiary.update_cat(cat, update_attrs)
      assert cat.name == "some updated name"
      assert cat.description == "some updated description"
      assert cat.birth_date == ~D[2024-03-04]
    end

    test "update_cat/2 with invalid data returns error changeset" do
      cat = cat_fixture()
      assert {:error, %Ecto.Changeset{}} = CatDiary.update_cat(cat, @invalid_attrs)
      assert cat == CatDiary.get_cat!(cat.id)
    end

    test "delete_cat/1 deletes the cat" do
      cat = cat_fixture()
      assert {:ok, %Cat{}} = CatDiary.delete_cat(cat)
      assert_raise Ecto.NoResultsError, fn -> CatDiary.get_cat!(cat.id) end
    end

    test "change_cat/1 returns a cat changeset" do
      cat = cat_fixture()
      assert %Ecto.Changeset{} = CatDiary.change_cat(cat)
    end
  end
end
