# Query object for finding records with weekly birthdays
class WeeklyBirthdayQuery

  # Initializes query to find record with weekly birthdays
  # @param [ActiveRecord::Relation] relation to use for finding weekly birthdays
  def initialize(relation = Person.all)
    @relation = relation
  end

  # Finds all the records with birthday during the current week
  # @return [Array<Person>] array of people with birthday this week
  def find_all
    @relation.select { |record|
      Week.current.include?(record.birthday.current)
    }.sort { |x,y| x.birthday <=> y.birthday }
  end

end
