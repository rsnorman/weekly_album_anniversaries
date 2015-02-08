# Models a album including the name, artist, release date anniversary and thumbnail image path
class Album < ActiveRecord::Base
  include HasUUID

  belongs_to :genre

  validates_presence_of :name
  validates_presence_of :artist
  validates_presence_of :release_date
  validates :release_date, release_date: true
  validates_uniqueness_of :name, :scope => :artist

  # Returns anniversary of album
  # @returns [Anniverary] anniversary of album
  def anniversary
    @anniversary ||= Anniversary.new(release_date)
  end

end
