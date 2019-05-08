# frozen_string_literal: true

require './lib/slugger'

# Models a album including the name, artist, release date anniversary and thumbnail image path
class Album < ActiveRecord::Base
  include HasUUID

  belongs_to :genre
  belongs_to :artist
  has_one :fun_fact

  validates_presence_of :name
  validates_presence_of :release_date
  validates_presence_of :slug
  validates :release_date, release_date: true
  validates_uniqueness_of :name, scope: :artist_id

  before_validation :set_slug

  delegate :name, to: :artist, prefix: true
  delegate :source, to: :fun_fact, prefix: true, allow_nil: true
  delegate :description, to: :fun_fact, prefix: true, allow_nil: true

  # Returns anniversary of album
  # @returns [Anniverary] anniversary of album
  def anniversary
    @anniversary ||= Anniversary.new(release_date)
  end

  def set_slug
    self.slug = Slugger.slug(artist.name, name)
  end

  def generated_fun_fact_description
    return unless fun_fact&.description

    fun_fact.description
            .gsub('[twitter]', artist.twitter_screen_name ? "@#{artist.twitter_screen_name}" : artist_name)
            .gsub('[album]', "\"#{name}\"")
  end
end
