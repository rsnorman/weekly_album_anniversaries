# frozen_string_literal: true

require_relative 'recent_twitter_interactors'

module AccountGrowth
  # Follows accounts that have recently interacted with system account
  class RecentInteractorFollower
    def self.follow_all
      new.follow_all
    end

    def initialize(twitter_client: WistfulIndie::Twitter::Client.client,
                   screen_names: RecentTwitterInteractors.screen_names)
      @client = twitter_client
      @screen_names = screen_names
    end

    def follow_all
      unfollowed_screen_names.each do |screen_name|
        begin
          puts "Following recent interactor: #{screen_name}"
          @client.follow(screen_name)
        rescue Twitter::Error::Forbidden
          Rails.logger.info 'Cannot follow system account'
        rescue Twitter::Error::NotFound
          Rails.logger.error "Account does not exist: #{screen_name}"
        end
      end
    end

    private

    def unfollowed_screen_names
      @screen_names - TwitterFollow.pluck(:screen_name)
    end
  end
end
