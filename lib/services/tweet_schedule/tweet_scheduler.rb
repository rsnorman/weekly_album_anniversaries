require './lib/random_week_datetime'

module TweetSchedule
  class TweetScheduler
    def initialize(albums:, type:, random_week_date_creator: RandomWeekDatetime)
      @albums = albums
      @type = type
      @random_week_date_creator = random_week_date_creator
    end

    def schedule_all
      @albums.each do |album|
        scheduled_tweet = schedule_tweet(album)
        next unless scheduled_tweet.errors.empty?
        puts "Scheduled #{album.artist_name} \"#{album.name}\" to tweet on "\
             "#{scheduled_tweet.scheduled_at.strftime('%A at %-l:%M %P')}"
      end
    end

    private

    def schedule_tweet(album)
      ScheduledTweet.create(
        type: @type,
        album: album,
        scheduled_at: scheduled_at
      )
    end

    def scheduled_at
      @random_week_date_creator.create
    end
  end
end
