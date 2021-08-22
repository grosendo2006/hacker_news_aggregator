import Config

config :hacker_news_aggregator, HackerNews.StoriesAPI,
  client_module: HackerNews.Client,
  base_url: "https://hacker-news.firebaseio.com/v0/",
  max_amount: 50

config :hacker_news_aggregator, HackerNewsAggregator.News, countdown: :timer.minutes(5)

import_config "#{Mix.env()}.exs"
