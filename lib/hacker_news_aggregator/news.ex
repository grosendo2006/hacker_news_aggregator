defmodule HackerNewsAggregator.News do
  use GenServer
  require Logger
  alias HackerNews.StoriesAPI

  @moduledoc """
  Every 5 minutes fetch the 50 top stories from https://github.com/HackerNews/API.
  """

  defmodule TopStories do
    defstruct top_stories_ids: [], top_stories: []
  end

  # Client

  @doc """
  Starts the worker process.
  """
  @spec start_link(GenServer.name()) :: GenServer.on_start()
  def start_link(_) do
    GenServer.start_link(__MODULE__, %TopStories{}, name: __MODULE__)
  end

  def top_stories() do
    GenServer.call(__MODULE__, :top_stories)
  end

  def top_story(id) do
    GenServer.call(__MODULE__, {:top_story, id})
  end

  #   Server
  @impl true
  def init(%TopStories{} = top_stories) do
    send(self(), :fetch_top_stories)
    {:ok, top_stories}
  end

  @impl true
  def handle_call(:top_stories, _from, %TopStories{top_stories: top_stories} = state) do
    {:reply, top_stories, state}
  end

  @impl true
  def handle_call({:top_story, id}, _from, %TopStories{top_stories: top_stories} = state) do
    case(Enum.find(top_stories, &(&1["id"] == id))) do
      nil ->
        case StoriesAPI.get_story(StoriesAPI.new(), id) do
          {:ok, story} ->
            {:reply, {:ok, story}, state}

          # There is no documentation about errors in https://github.com/HackerNews/API,
          # so I'm asuming this kind of error
          {:error, reason} ->
            {:reply, {:error, reason}, state}

          error ->
            {:reply, error, state}
        end

      top_story ->
        {:reply, {:ok, top_story}, state}
    end
  end

  @impl true
  def handle_info(:fetch_top_stories, top_stories) do
    Logger.info("Fetching top stories")

    {:ok, top_stories_ids} = StoriesAPI.top_stories(StoriesAPI.new())

    Process.send_after(self(), :fetch_top_stories, 300_000)
    Process.send_after(self(), :get_top_stories, 100)

    {:noreply, Map.put(top_stories, :top_stories_ids, top_stories_ids)}
  end

  def handle_info(:get_top_stories, %TopStories{top_stories_ids: stories_ids} = top_stories) do
    {:noreply, Map.put(top_stories, :top_stories, Enum.map(stories_ids, &get_story(&1)))}
  end

  defp get_story(id) do
    {:ok, story} = StoriesAPI.get_story(StoriesAPI.new(), id)
    story
  end
end
