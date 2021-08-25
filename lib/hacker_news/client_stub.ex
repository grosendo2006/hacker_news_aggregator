defmodule HackerNews.Client.Stub do
  @moduledoc """
  HackerNews Stub Client
  """

  @behaviour HackerNews.StoriesAPI

  @impl true
  def top_stories(config) do
    {:ok,
     [1, 2, 3, 4, 5]
     |> Enum.take(config.max_amount)}
  end

  def get_story(config, "**") do
    {:error, :not_found}
  end

  @impl true
  def get_story(config, id) do
    {:ok,
     %{
       "by" => "dhouston",
       "id" => id,
       "title" => "My YC app: Dropbox - Throw away your USB drive",
       "type" => "story"
     }}
  end

  # @impl true
  # def update_referral(params) do
  #   {:ok,
  #    %CustomerReferee{
  #      customer_id: params["customer_id"],
  #      referee_id: params["referee_id"],
  #      referrer_name: "Bob A.",
  #      referee_name: "john D.",
  #      total_usd_balance: Decimal.new("123.4"),
  #      referral_step: :account_created
  #    }}
  # end

  # @impl true
  # def list(_customer_id, _params) do
  #   %Scrivener.Page{
  #     entries: [
  #       %{
  #         referee_name: "Bob A.",
  #         referral_step: :account_created
  #       }
  #     ]
  #   }
  # end
end
