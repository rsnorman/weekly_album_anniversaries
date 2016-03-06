class PotentialTwitterScreenName < ActiveRecord::Base
  belongs_to :artist

  default_scope { order(strength: :desc) }
end
