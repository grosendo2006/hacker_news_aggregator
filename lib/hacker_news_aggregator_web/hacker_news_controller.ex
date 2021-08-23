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
    {:ok, resp} = News.story(id)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(resp))
  end

  defp maybe_put_default_config(%{page: _page_number, page_size: _page_size} = params), do: params
  defp maybe_put_default_config(_params), do: %Scrivener.Config{page_number: 1, page_size: 10}
end
