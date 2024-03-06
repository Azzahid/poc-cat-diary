defmodule CatDiaryPocWeb.DiaryLiveTest do
  use CatDiaryPocWeb.ConnCase

  import Phoenix.LiveViewTest
  import CatDiaryPoc.CatDiaryFixtures

  @create_attrs %{date: "2024-03-03", title: "some title", cat: "some cat", text: "some text"}
  @update_attrs %{date: "2024-03-04", title: "some updated title", cat: "some updated cat", text: "some updated text"}
  @invalid_attrs %{date: nil, title: nil, cat: nil, text: nil}

  defp create_diary(_) do
    diary = diary_fixture()
    %{diary: diary}
  end

  describe "Index" do
    setup [:create_diary]

    test "lists all diaries", %{conn: conn, diary: diary} do
      {:ok, _index_live, html} = live(conn, ~p"/diaries")

      assert html =~ "Listing Diaries"
      assert html =~ diary.title
    end

    test "saves new diary", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/diaries")

      assert index_live |> element("a", "New Diary") |> render_click() =~
               "New Diary"

      assert_patch(index_live, ~p"/diaries/new")

      assert index_live
             |> form("#diary-form", diary: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#diary-form", diary: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/diaries")

      html = render(index_live)
      assert html =~ "Diary created successfully"
      assert html =~ "some title"
    end

    test "updates diary in listing", %{conn: conn, diary: diary} do
      {:ok, index_live, _html} = live(conn, ~p"/diaries")

      assert index_live |> element("#diaries-#{diary.id} a", "Edit") |> render_click() =~
               "Edit Diary"

      assert_patch(index_live, ~p"/diaries/#{diary}/edit")

      assert index_live
             |> form("#diary-form", diary: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#diary-form", diary: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/diaries")

      html = render(index_live)
      assert html =~ "Diary updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes diary in listing", %{conn: conn, diary: diary} do
      {:ok, index_live, _html} = live(conn, ~p"/diaries")

      assert index_live |> element("#diaries-#{diary.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#diaries-#{diary.id}")
    end
  end

  describe "Show" do
    setup [:create_diary]

    test "displays diary", %{conn: conn, diary: diary} do
      {:ok, _show_live, html} = live(conn, ~p"/diaries/#{diary}")

      assert html =~ "Show Diary"
      assert html =~ diary.title
    end

    test "updates diary within modal", %{conn: conn, diary: diary} do
      {:ok, show_live, _html} = live(conn, ~p"/diaries/#{diary}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Diary"

      assert_patch(show_live, ~p"/diaries/#{diary}/show/edit")

      assert show_live
             |> form("#diary-form", diary: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#diary-form", diary: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/diaries/#{diary}")

      html = render(show_live)
      assert html =~ "Diary updated successfully"
      assert html =~ "some updated title"
    end
  end
end
