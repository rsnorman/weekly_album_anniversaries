require './app/form_objects/twitter_follow_creator'
require './lib/services/new_twitter_friend_accumulator'

# Tracks new twitter friend accounts
class NewTwitterFriendTracker
  def initialize(new_twitter_friends: NewTwitterFriendAccumulator.all,
                 follow_ids: TwitterFollowerId.all)
    @new_twitter_friends = new_twitter_friends
    @follow_ids = follow_ids
  end

  def track_all
    @new_twitter_friends.each do |twitter_account|
      TwitterFollowCreator.new(twitter_id: twitter_account.id,
                               screen_name: twitter_account.screen_name,
                               follow_ids: @follow_ids).save
    end
  end
end
