defmodule HackerNewsAggregatorWeb.HackerNewsController do
  import Plug.Conn
  alias HackerNewsAggregator.News

  def get_stories(%Plug.Conn{params: params} = conn) do
    config = maybe_put_default_config(params)

    resp =
      News.top_stories() |> Scrivener.paginate(config) |> Map.from_struct() |> Jason.encode!()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, resp)
  end

  def get_story(conn) do
    {:ok, id} = Map.fetch(conn.params, "id")

    case News.story(id) do
      {:ok, resp} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(resp))

      {:error, :not_found} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!("not found story with id #{id}"))

      _error ->
        {:error, :internal_server_error}
    end
  end

  defp maybe_put_default_config(%{page: page_number, page_size: page_size}),
    do: %Scrivener.Config{page_number: page_number, page_size: page_size}

  defp maybe_put_default_config(_params), do: %Scrivener.Config{page_number: 1, page_size: 10}
end
