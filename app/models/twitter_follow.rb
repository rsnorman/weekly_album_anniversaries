# frozen_string_literal: true

class TwitterFollow < ActiveRecord::Base
  belongs_to :artist

  validates :twitter_id, uniqueness: true, presence: true
  validates :screen_name, uniqueness: true, presence: true
  validates :artist_id, uniqueness: { allow_nil: true }

  scope :artist, -> { where.not(artist_id: nil) }
  scope :friend, -> { where(is_friend: true) }
  scope :ungrateful, -> { where(artist_id: nil, is_friend: false) }
end
