namespace :weekly_albums do
  desc "Finds obvious twitter screen names and assigns to users"
  task set_twitter_screen_name: :environment do
    require './lib/wistful_indie/twitter/screen_name_assigner'

    puts "Setting Twitter screen names..."
    Artist.where(twitter_screen_name: nil).where.not(id: PotentialTwitterScreenName.pluck(:artist_id).uniq).limit(1).each do |artist|
      puts "Finding twitter screen name for #{artist.name}…"
      if WistfulIndie::Twitter::ScreenNameAssigner.new(artist).assign
        puts "Found Twitter screen name: @#{artist.twitter_screen_name}"
      else
        puts "Could not find twitter screen name for #{artist.name}"
      end
    end
    puts "Finished setting all artist screen names"
  end
end
