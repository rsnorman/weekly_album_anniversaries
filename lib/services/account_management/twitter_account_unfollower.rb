# frozen_string_literal: true

module AccountManagement
  # Unfollows accounts that haven't followed back
  class TwitterAccountUnfollower
    def self.unfollow
      new.unfollow
    end

    def initialize(twitter_client: WistfulIndie::Twitter::Client.client,
                   accounts: UngratefulTwitterFollows.all)
      @twitter_client = twitter_client
      @accounts = accounts
    end

    def unfollow
      @accounts.each do |account|
        puts "Unfollowing #{account.screen_name}"
        @twitter_client.unfollow(account.twitter_id.to_i)
        account.destroy
      end
    rescue Twitter::Error::TooManyRequests
      Rails.logger.error 'Too many unfollows'
    end
  end
end
