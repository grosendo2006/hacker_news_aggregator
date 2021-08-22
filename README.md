# HackerNewsAgregator

HACKER NEWS AGGREGATOR

The Hacker News aggregator fetches data from the Hacker News API for furtheranalysis or consumption.The api documentation is available at: https://github.com/HackerNews/API.

FEATURES

Every 5 minutes fetch the 50 top stories (polling the HN api)Make stories available via two public APIs: JSON over http and JSON overWebSockets (more details below)

PUBLIC APIs

The http api should provide a way to list stories with pagination (10 results perpage)The http api should provide a way to fetch a single story. Upon connection, The WebSockets api should send a the 50 top stories. Whenstories get refreshed, new stories should be sent.

ESSENTIAL CONSTRAINTS

All components need to be properly supervised. All data should be kept memory (e.g. no external databases)

NICE TO HAVE

Non blocking operations: for example fetching new stories should not affect the ability to read data currently in memory.
Testing: a strategy for testing the single components with some examples (it’sfine to leave some tests as pending as long as they explain what they wouldtest). Type and function specifications.

REVIEW

ESL will review your implementation considering the following criteria:Resilience (e.g. what happens if the HN api is down?)Performance (e.g. are there bottlenecks that can be identified without even loadtesting the application?)Clarity (e.g. can I just open the Observer application and get a good insight onthe application structure? Is there clear intent in function names?)Security (e.g. are there ways that the public API could be abused?)OTP usage (e.g. does this component need to be a supervised worker or is itmore appropriate to just spawn a process?)Usage of dependencies (e.g. is it worth pulling in an entire package just for asingle function?)Commit history (e.g. are commit messages clear ? does each commit representa unique and individual change?)

MORE THAN ONE WAY TO DO IT

Some of the features imply choosing among tradeoffs in consistency, performanceand resilience. In those instances, feel free to leave a comment in the code to showthat you’re aware of them. The point of this exercise is to highlight your ability toreason around constraints

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hacker_news_agregator` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:hacker_news_agregator, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/hacker_news_agregator](https://hexdocs.pm/hacker_news_agregator).

