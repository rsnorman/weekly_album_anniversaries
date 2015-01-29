# Birthday value object
class Birthday
  include Comparable

  # Intializes a birthday object with date of birth
  # @param [Date] date_of_birth for birthday
  def initialize(date_of_birth)
    @date_of_birth = date_of_birth
  end

  # Returns the upcoming date of birthday or current one (based on week)
  # @returns [Date] date of current birthday
  def current
    @current ||=
      begin
        # Need to account for birthdays at the beginning of next year
        week = Week.current
        year = @date_of_birth.month == week.start.month ?
          week.start.year :
          week.end.year

        @date_of_birth.dup.change(year: year)
      end
  end

  # Returns the number of birthdays that have passed
  # Counts current week as birthday passing
  # @return [Integer] number of birthdays
  def count
    @count ||= Date.current.year - @date_of_birth.year
  end

  # Compares birthdays on current date of birthday
  # @param [Birthday] other birthday to compare
  # @return [Integer] -1 for less, 0 for equal, and 1 for greater
  def <=>(other)
    current <=> other.current
  end

end
