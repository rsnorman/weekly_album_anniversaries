namespace :weekly_albums do
  desc "Downloads and inserts BNM albums"
  task :download_bnm => :environment do
    require "./lib/services/bnm_album_downloader_service"

    puts "Downloading Best New Music..."
    BnmAlbumDownloaderService.new(timeout: 5).download
    puts "Finished downloading Best New Music"
  end

  desc "Highlights album that has anniversary today"
  task :highlight_anniversary => :environment do
    require "./lib/services/highlight_daily_anniversary_service"

    puts "Highlighting daily anniversary..."
    HighlightDailyAnniversaryService.new.tweet
    puts "Finished finished highlighting anniversary"
  end

  desc "Schedules top songs from highlighted albums"
  task schedule_top_songs: :environment do
    return unless Date.current.wday == 1 # Only send on Monday
    require './lib/services/top_song_tweet_scheduler'
    TopSongTweetScheduler.new(albums: WeeklyAnniversaryQuery.all).schedule_all
  end

  desc "Highlights top songs that have anniversary this week"
  task highlight_top_songs: :environment do
    require './lib/services/top_song_scheduled_tweeter'
    TopSongScheduledTweeter.tweet_all
  end
end
