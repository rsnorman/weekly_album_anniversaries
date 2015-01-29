class Client < ActiveRecord::Base
  include HasUUID

  has_many :people, :dependent => :destroy

  validates_presence_of :name
end
