defmodule CatDiaryPocWeb.CatLiveTest do
  use CatDiaryPocWeb.ConnCase

  import Phoenix.LiveViewTest
  import CatDiaryPoc.CatDiaryFixtures

  @create_attrs %{name: "some name", description: "some description", birth_date: "2024-03-03"}
  @update_attrs %{name: "some updated name", description: "some updated description", birth_date: "2024-03-04"}
  @invalid_attrs %{name: nil, description: nil, birth_date: nil}

  defp create_cat(_) do
    cat = cat_fixture()
    %{cat: cat}
  end

  describe "Index" do
    setup [:create_cat]

    test "lists all cats", %{conn: conn, cat: cat} do
      {:ok, _index_live, html} = live(conn, ~p"/cats")

      assert html =~ "Listing Cats"
      assert html =~ cat.name
    end

    test "saves new cat", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cats")

      assert index_live |> element("a", "New Cat") |> render_click() =~
               "New Cat"

      assert_patch(index_live, ~p"/cats/new")

      assert index_live
             |> form("#cat-form", cat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cat-form", cat: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cats")

      html = render(index_live)
      assert html =~ "Cat created successfully"
      assert html =~ "some name"
    end

    test "updates cat in listing", %{conn: conn, cat: cat} do
      {:ok, index_live, _html} = live(conn, ~p"/cats")

      assert index_live |> element("#cats-#{cat.id} a", "Edit") |> render_click() =~
               "Edit Cat"

      assert_patch(index_live, ~p"/cats/#{cat}/edit")

      assert index_live
             |> form("#cat-form", cat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#cat-form", cat: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cats")

      html = render(index_live)
      assert html =~ "Cat updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes cat in listing", %{conn: conn, cat: cat} do
      {:ok, index_live, _html} = live(conn, ~p"/cats")

      assert index_live |> element("#cats-#{cat.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cats-#{cat.id}")
    end
  end

  describe "Show" do
    setup [:create_cat]

    test "displays cat", %{conn: conn, cat: cat} do
      {:ok, _show_live, html} = live(conn, ~p"/cats/#{cat}")

      assert html =~ "Show Cat"
      assert html =~ cat.name
    end

    test "updates cat within modal", %{conn: conn, cat: cat} do
      {:ok, show_live, _html} = live(conn, ~p"/cats/#{cat}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Cat"

      assert_patch(show_live, ~p"/cats/#{cat}/show/edit")

      assert show_live
             |> form("#cat-form", cat: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#cat-form", cat: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/cats/#{cat}")

      html = render(show_live)
      assert html =~ "Cat updated successfully"
      assert html =~ "some updated name"
    end
  end
end
