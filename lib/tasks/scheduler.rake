namespace :weekly_albums do
  desc "Downloads and inserts BNM albums"
  task :download_bnm => :environment do
    require "./lib/services/album_download/bnm_album_downloader_service"

    puts "Downloading Best New Music..."
    AlbumDownload::BnmAlbumDownloaderService.new(timeout: 5).download
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
    if Date.current.wday == 1 # Only send on Monday
      require './lib/services/tweet_schedule/tweet_scheduler'
      TweetSchedule::TweetScheduler.new(albums: WeeklyAnniversaryQuery.all,
                                        type: 'TopSong').schedule_all
    end
  end

  desc "Schedules top song lyrics from highlighted albums"
  task schedule_top_song_lyrics: :environment do
    if Date.current.wday == 1 # Only send on Monday
      require './lib/services/tweet_schedule/tweet_scheduler'
      TweetSchedule::TweetScheduler.new(albums: WeeklyAnniversaryQuery.all,
                                        type: 'TopLyrics').schedule_all
    end
  end

  desc "Highlights top songs that have anniversary this week"
  task highlight_top_songs: :environment do
    require './lib/services/tweet_schedule/top_song_scheduled_tweeter'
    TweetSchedule::TopSongScheduledTweeter.tweet_all
  end

  desc "Highlights top song lyrics that have anniversary this week"
  task highlight_top_song_lyrics: :environment do
    require './lib/services/tweet_schedule/top_lyrics_scheduled_tweeter'
    TweetSchedule::TopLyricsScheduledTweeter.tweet_all
  end
end
