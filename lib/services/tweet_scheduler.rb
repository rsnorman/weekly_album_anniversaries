require './lib/random_week_datetime'

class TweetScheduler
  def initialize(albums:, type:, random_week_date_creator: RandomWeekDatetime)
    @albums = albums
    @random_week_date_creator = random_week_date_creator
  end

  def schedule_all
    @albums.each do |album|
      ScheduledTweet.create(
        type: 'TopSong',
        album: album,
        scheduled_at: scheduled_at
      )
    end
  end

  private

  def scheduled_at
    @random_week_date_creator.create
  end
end
