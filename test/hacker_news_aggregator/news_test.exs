defmodule HackerNewsAggregator.News.Test do
  use ExUnit.Case, async: true
  alias HackerNewsAggregator.News

  setup do
    # Genserver needs some time to start
    :timer.sleep(3000)

    :ok
  end

  describe "get story" do
    test "return a story with id given" do
      assert {:ok,
              %{
                "by" => "dhouston",
                "id" => 1,
                "title" => "My YC app: Dropbox - Throw away your USB drive",
                "type" => "story"
              }} = News.story(1)
    end

    test "return error if invalid id is given" do
      assert {:error, :not_found} = News.story("**") |> IO.inspect()
    end
  end

  describe "top stories" do
    test "return top stories" do
      assert resp = News.top_stories()
      assert Enum.count(resp) == 2

      assert [
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
             ] == resp
    end
  end
end
