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
        ScheduledTweet.create(
          type: @type,
          album: album,
          scheduled_at: scheduled_at
        )
        puts "Scheduled #{album.artist_name} \"#{album.name}\" to tweet on #{scheduled_at.strftime('%A at %-l:%M %P')}"
      end
    end

    private

    def scheduled_at
      @random_week_date_creator.create
    end
  end
end
