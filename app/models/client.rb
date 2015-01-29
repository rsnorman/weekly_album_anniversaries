class Client < ActiveRecord::Base
  include HasUUID

  has_many :people

  validates_presence_of :name
end
