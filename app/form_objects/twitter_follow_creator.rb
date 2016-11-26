class TwitterFollowCreator
  def initialize(attributes = {})
    @follow_ids = attributes.delete(:follow_ids) || []
    @attributes = attributes
  end

  def save
    TwitterFollow.create(twitter_follow_attributes)
  end

  private

  def twitter_follow_attributes
    @attributes.merge(is_friend: following?, artist: artist)
  end

  def following?
    @follow_ids.map(&:to_i).include?(@attributes[:twitter_id].to_i)
  end

  def artist
    Artist.find_by(twitter_screen_name: @attributes[:screen_name])
  end
end
