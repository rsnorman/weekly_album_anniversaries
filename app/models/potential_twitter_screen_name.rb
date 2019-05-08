# frozen_string_literal: true

class PotentialTwitterScreenName < ActiveRecord::Base
  belongs_to :artist

  default_scope { order(strength: :desc) }
end
