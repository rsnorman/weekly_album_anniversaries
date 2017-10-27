class ScheduledTweet < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  belongs_to :album

  scope :songs, -> { where(type: 'TopSong') }
  scope :lyrics, -> { where(type: 'TopLyrics') }
  scope :albums, -> { where(type: 'AlbumAnniversary') }
  scope :fun_facts, -> { where(type: 'FunFacts') }
  scope :during_dates, -> (date_range) do
    end_date = date_range.last + 23.hours + 59.minutes + 59.seconds
    where(scheduled_at: date_range.first..end_date)
  end

  default_scope { order(:scheduled_at) }

  validates_with ScheduledAtValidator
end
