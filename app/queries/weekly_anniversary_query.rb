# Query object for finding records with weekly anniversaries
class WeeklyAnniversaryQuery

  # Initializes query to find record with weekly anniversaries
  # @param [ActiveRecord::Relation] relation to use for finding weekly anniversaries
  def initialize(relation = Album.all, week = Week.current)
    @relation = relation
    @week = week
  end

  # Finds all the records with anniversary during the current week
  # @return [Array<Album>] array of albums with anniversary this week
  def find_all
    Rails.cache.fetch(weekly_album_cache_key) do
      weekly_albums.sort do |x,y|
        x.anniversary.current <=> y.anniversary.current
      end
    end
  end

  private

  def weekly_albums
    @relation.select { |album| @week.include?(album.anniversary.current) }
  end

  def weekly_album_cache_key
    count          = @relation.count
    max_updated_at = @relation.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "albums/all-#{count}-#{max_updated_at}-#{@week.number}"
  end

end
