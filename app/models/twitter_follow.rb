class TwitterFollow < ActiveRecord::Base
  belongs_to :artist

  scope :artist, -> { where.not(artist_id: nil) }
  scope :friend, -> { where(is_friend: true) }
  scope :ungrateful, -> { where(artist_id: nil, is_friend: false) }
end
