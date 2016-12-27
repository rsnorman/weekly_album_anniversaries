require_relative 'twitter_friend_id'

module AccountManagement
  # Collects all new twitter friend accounts
  class NewTwitterFriendAccumulator
    def self.all
      new.all
    end

    def initialize(twitter_friend_ids: TwitterFriendId.all,
                   current_follows: TwitterFollow.all,
                   twitter_client: WistfulIndie::Twitter::Client.client)
      @twitter_friend_ids = twitter_friend_ids
      @current_follows = current_follows
      @twitter_client = twitter_client
    end

    def all
      untracked_friend_ids.map do |friend_id|
        @twitter_client.user(friend_id)
      end
    end

    private

    def untracked_friend_ids
      @twitter_friend_ids - @current_follows.pluck(:twitter_id).map(&:to_i)
    end
  end
end
