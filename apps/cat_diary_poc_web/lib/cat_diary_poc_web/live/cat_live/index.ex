defmodule CatDiaryPocWeb.CatLive.Index do
  use CatDiaryPocWeb, :live_view

  alias CatDiaryPoc.CatDiary
  alias CatDiaryPoc.CatDiary.Cat

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cats, CatDiary.list_cats())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cat")
    |> assign(:cat, CatDiary.get_cat!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cat")
    |> assign(:cat, %Cat{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cats")
    |> assign(:cat, nil)
  end

  @impl true
  def handle_info({CatDiaryPocWeb.CatLive.FormComponent, {:saved, cat}}, socket) do
    {:noreply, stream_insert(socket, :cats, cat)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cat = CatDiary.get_cat!(id)
    {:ok, _} = CatDiary.delete_cat(cat)

    {:noreply, stream_delete(socket, :cats, cat)}
  end
end
