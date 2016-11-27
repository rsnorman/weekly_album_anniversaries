require_relative 'twitter_follower_id'

# Updates friend accounts that have followed back
class TwitterFriendUpdater
  def initialize(non_friend_follows: TwitterFollow.where(is_friend: false),
                 follow_ids: TwitterFollowerId.all)
    @non_friend_follows = non_friend_follows
    @follow_ids = follow_ids
  end

  def update
    unfriended_follows.each do |follow|
      follow.update(is_friend: true)
    end
  end

  private

  def unfriended_follows
    @non_friend_follows.where(twitter_id: unfriended_twitter_ids)
  end

  def unfriended_twitter_ids
    @follow_ids -
      @non_friend_follows.where(is_friend: true).pluck(:twitter_id).map(&:to_i)
  end
end
