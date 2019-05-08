# frozen_string_literal: true

module AccountManagement
  # Enumerable for twitter follower IDs
  class TwitterFollowerId
    def self.all
      new.all
    end

    def initialize(twitter_client: WistfulIndie::Twitter::Client.client)
      @twitter_client = twitter_client
    end

    def all
      @twitter_client.follower_ids.to_a
    end
  end
end
