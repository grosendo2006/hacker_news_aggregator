import Config

config :hacker_news_aggregator, :env, :test

config :hacker_news_aggregator, HackerNews.StoriesAPI,
  client_module: HackerNews.Client.Stub,
  base_url: "https://hacker-news.firebaseio.com/v0/",
  max_amount: 2
