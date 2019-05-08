# frozen_string_literal: true

module AccountManagement
  # Enumerable for twitter friend IDs
  class TwitterFriendId
    def self.all(twitter_client: WistfulIndie::Twitter::Client.client)
      twitter_client.friend_ids.to_a
    end
  end
end
