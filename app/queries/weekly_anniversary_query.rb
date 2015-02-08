# Query object for finding records with weekly anniversaries
class WeeklyAnniversaryQuery

  # Initializes query to find record with weekly anniversaries
  # @param [ActiveRecord::Relation] relation to use for finding weekly anniversaries
  def initialize(relation = Album.all)
    @relation = relation
  end

  # Finds all the records with anniversary during the current week
  # @return [Array<Album>] array of albums with anniversary this week
  def find_all
    @relation.select { |record|
      Week.current.include?(record.anniversary.current)
    }.sort { |x,y| x.anniversary <=> y.anniversary }
  end

end