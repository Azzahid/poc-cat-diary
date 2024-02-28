defmodule CatDiaryPoc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CatDiaryPoc.Repo,
      {DNSCluster, query: Application.get_env(:cat_diary_poc, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CatDiaryPoc.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CatDiaryPoc.Finch}
      # Start a worker by calling: CatDiaryPoc.Worker.start_link(arg)
      # {CatDiaryPoc.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: CatDiaryPoc.Supervisor)
  end
end
