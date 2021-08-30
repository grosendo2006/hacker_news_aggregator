defmodule HackerNewsAggregatorWeb.Router do
  use Plug.Router
  alias HackerNewsAggregatorWeb.HackerNewsController

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["text/*"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  get "/top_stories" do
    HackerNewsController.get_stories(conn)
  end

  get "/story" do
    HackerNewsController.get_story(conn)
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
