# frozen_string_literal: true

class Genre < ActiveRecord::Base
  include HasUUID

  has_many :albums, dependent: :destroy

  validates_presence_of :name
end
