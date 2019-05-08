# frozen_string_literal: true

# Anniversary value object
class Anniversary
  include Comparable

  # Intializes a anniversary object with release date
  # @param [Date] release_date for anniversary
  def initialize(release_date)
    @release_date = release_date
  end

  # Returns the upcoming date of anniversary or current one (based on week)
  # @returns [Date] date of current anniversary
  def current
    @current ||=
      begin
        # Need to account for anniversaries at the beginning of next year
        week = Week.current
        year = @release_date.month == week.start.month ?
          week.start.year :
          week.end.year

        @release_date.dup.change(year: year)
      rescue StandardError
        # Probably a leap year
      end
  end

  # Returns the number of anniversaries that have passed
  # Counts current week as anniversary passing
  # @return [Integer] number of anniversaries
  def count
    @count ||= Date.current.year - @release_date.year
  end

  # Compares anniversaries on current date of anniversary
  # @param [Anniversary] other anniversary to compare
  # @return [Integer] -1 for less, 0 for equal, and 1 for greater
  def <=>(other)
    other.count <=> count
  end
end
