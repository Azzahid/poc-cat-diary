defmodule CatDiaryPocWeb.DiaryLive.FormComponent do
  use CatDiaryPocWeb, :live_component

  alias CatDiaryPoc.CatDiary

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage diary records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="diary-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:text]} type="text" label="Text" />
        <.input field={@form[:date]} type="date" label="Date" />
        <.input field={@form[:cat]} type="text" label="Cat" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Diary</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{diary: diary} = assigns, socket) do
    changeset = CatDiary.change_diary(diary)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"diary" => diary_params}, socket) do
    changeset =
      socket.assigns.diary
      |> CatDiary.change_diary(diary_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"diary" => diary_params}, socket) do
    save_diary(socket, socket.assigns.action, diary_params)
  end

  defp save_diary(socket, :edit, diary_params) do
    case CatDiary.update_diary(socket.assigns.diary, diary_params) do
      {:ok, diary} ->
        notify_parent({:saved, diary})

        {:noreply,
         socket
         |> put_flash(:info, "Diary updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_diary(socket, :new, diary_params) do
    case CatDiary.create_diary(diary_params) do
      {:ok, diary} ->
        notify_parent({:saved, diary})

        {:noreply,
         socket
         |> put_flash(:info, "Diary created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
