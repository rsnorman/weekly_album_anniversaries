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

namespace :twitter do
  namespace :admin do
    desc 'Tracks all new twitter friends'
    task track_friends: :environment do
      require './lib/services/new_twitter_friend_tracker'
      NewTwitterFriendTracker.track_all
    end

    desc 'Updates follow backs since tracking twitter friends'
    task update_follow_backs: :environment do
      require './lib/services/twitter_friend_updater'
      TwitterFriendUpdater.update
    end

    desc 'Removes ungrateful Twitter follows'
    task unfollow_ungrateful: :environment do
      require './lib/services/twitter_friend_updater'
      require './lib/services/twitter_account_unfollower'
      TwitterFriendUpdater.update
      TwitterAccountUnfollower.unfollow
    end
  end

  desc 'Follow accounts with recent interactions'
  task follow_recent: :environment do
    require './lib/services/recent_interactor_follower'
    RecentInteractorFollower.follow_all
  end
end
