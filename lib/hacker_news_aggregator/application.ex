defmodule HackerNewsAggregator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {HackerNewsAggregator.News, []},
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: HackerNewsAggregatorWeb.Router,
        options: [port: 4001]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HackerNewsAggregator]
    Supervisor.start_link(children, opts)
  end
end
