# frozen_string_literal: true

# Returns scheduled tweets that are active
class ActiveScheduledTweet
  SCHEDULED_AT_TIME_AGO = 6.minutes
  SCHEDULED_AT_TIME_FROM_NOW = 5.minutes

  def self.all
    new.all
  end

  def initialize(scheduled_tweets: ScheduledTweet.all)
    @scheduled_tweets = scheduled_tweets
  end

  def all
    @scheduled_tweets
      .where('scheduled_at <= ?', Time.current + SCHEDULED_AT_TIME_FROM_NOW)
      .where(tweet_id: nil)
  end
end
