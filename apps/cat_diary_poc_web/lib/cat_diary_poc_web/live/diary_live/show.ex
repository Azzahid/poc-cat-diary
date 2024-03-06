defmodule CatDiaryPocWeb.DiaryLive.Show do
  use CatDiaryPocWeb, :live_view

  alias CatDiaryPoc.CatDiary

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:diary, CatDiary.get_diary!(id))}
  end

  defp page_title(:show), do: "Show Diary"
  defp page_title(:edit), do: "Edit Diary"
end
