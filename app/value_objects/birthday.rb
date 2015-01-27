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
        start_of_week = Date.current.beginning_of_week
        end_of_week   = Date.current.end_of_week

        # Need to account for birthdays at the beginning of next year
        year          = @date_of_birth.month == start_of_week.month ?
                        start_of_week.year :
                        end_of_week.year

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