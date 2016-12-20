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
    @scheduled_tweets.where('scheduled_at BETWEEN ? AND ?',
                            Time.current - SCHEDULED_AT_TIME_AGO,
                            Time.current + SCHEDULED_AT_TIME_FROM_NOW)
  end
end
