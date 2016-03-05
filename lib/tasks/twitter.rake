namespace :weekly_albums do
  desc "Finds obvious twitter screen names and assigns to users"
  task :set_twitter_screen_name => :environment do
    require "./lib/wistful_indie/twitter/user_finder"

    puts "Setting Twitter screen names..."
    finder = WistfulIndie::Twitter::UserFinder.new
    Artist.all.each do |artist|
      puts "Fetching twitter accounts for #{artist.name}"
      screen_names = finder.all_verified_for_artist(artist.name)
      next if screen_names.size > 1
      next if screen_names.empty?
      puts "Found twitter name: @#{screen_names.first}"
      artist.update(twitter_screen_name: screen_names.first)
    end
    puts "Finished setting all artist screen names"
  end
end
