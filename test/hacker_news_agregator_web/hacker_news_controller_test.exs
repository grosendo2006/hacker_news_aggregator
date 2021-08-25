defmodule HackerNewsAggregatorWeb.HackerNewsControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias HackerNewsAggregatorWeb.HackerNewsController
  # alias HackerNewsAggregator.News

  setup do
    # Genserver needs some time to start
    :timer.sleep(3000)

    :ok
  end

  describe "get stories" do
    test "lists top stories" do
      conn = conn(:get, "/top_stories")

      assert %Plug.Conn{resp_body: body, status: 200} = HackerNewsController.get_stories(conn)

      assert %{
               "entries" => [
                 %{
                   "by" => "dhouston",
                   "id" => 1,
                   "title" => "My YC app: Dropbox - Throw away your USB drive",
                   "type" => "story"
                 },
                 %{
                   "by" => "dhouston",
                   "id" => 2,
                   "title" => "My YC app: Dropbox - Throw away your USB drive",
                   "type" => "story"
                 }
               ],
               "page_number" => 1,
               "total_entries" => 2
             } = Jason.decode!(body)
    end
  end

  describe "get story" do
    test "list a specific story" do
      conn = conn(:get, "/story", %{id: 9999})

      assert %Plug.Conn{resp_body: body, status: 200} = HackerNewsController.get_story(conn)

      assert %{"by" => _by, "id" => "9999", "title" => _some_text} = Jason.decode!(body)
    end

    test "return an error if invalid_id is receiving" do
      conn = conn(:get, "/story", %{id: "**"})

      assert %Plug.Conn{resp_body: body, status: 404} = HackerNewsController.get_story(conn)

      assert Jason.decode!(body) =~ "not found story with id"
    end
  end
end
