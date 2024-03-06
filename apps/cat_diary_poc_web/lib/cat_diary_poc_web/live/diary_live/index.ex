defmodule CatDiaryPocWeb.DiaryLive.Index do
  use CatDiaryPocWeb, :live_view

  alias CatDiaryPoc.CatDiary
  alias CatDiaryPoc.CatDiary.Diary

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :diaries, CatDiary.list_diaries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Diary")
    |> assign(:diary, CatDiary.get_diary!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Diary")
    |> assign(:diary, %Diary{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Diaries")
    |> assign(:diary, nil)
  end

  @impl true
  def handle_info({CatDiaryPocWeb.DiaryLive.FormComponent, {:saved, diary}}, socket) do
    {:noreply, stream_insert(socket, :diaries, diary)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    diary = CatDiary.get_diary!(id)
    {:ok, _} = CatDiary.delete_diary(diary)

    {:noreply, stream_delete(socket, :diaries, diary)}
  end
end
