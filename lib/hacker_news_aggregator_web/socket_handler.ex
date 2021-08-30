defmodule HackerNewsAggregatorWeb.SocketHandler do
  @behaviour :cowboy_websocket

  def init(request, _state) do
    state = %{registry_key: :web_socket_top_stories}

    {:cowboy_websocket, request, state}
  end

  def websocket_init(state) do
    Registry.HackerNewsAggregator
    |> Registry.register(state.registry_key, {})

    {:ok, state}
  end

  def websocket_handle({:text, json}, state) do
    {:reply, {:text, json}, state}
  end

  @doc """
  Send top stories to client
  """
  def websocket_info({:top_stories, top_stories}, state) do
    message = Jason.encode!(top_stories)
    {:reply, {:text, message}, state}
  end
end
