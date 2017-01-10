class ScheduledTweet < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :album

  scope :songs, -> { where(type: 'TopSong') }
  scope :lyrics, -> { where(type: 'TopLyrics') }
  scope :albums, -> { where(type: 'AlbumAnniversary') }
  scope :during_dates, -> (date_range) { where(scheduled_at: date_range) }

  default_scope { order(:scheduled_at) }

  validates_with ScheduledAtValidator
end
