class ScheduledTweet < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :album

  scope :songs, -> { where(type: 'TopSong') }
  scope :lyrics, -> { where(type: 'TopLyrics') }
  scope :albums, -> { where(type: 'AlbumAnniversary') }
end
