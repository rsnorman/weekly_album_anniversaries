class Artist < ActiveRecord::Base
  include HasUUID

  has_many :potential_twitter_screen_names
end
