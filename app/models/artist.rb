# frozen_string_literal: true

class Artist < ActiveRecord::Base
  include HasUUID

  has_many :albums, dependent: :destroy
  has_many :potential_twitter_screen_names
end
