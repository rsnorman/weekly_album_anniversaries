# Value object for modeling a week in the year
class Week
  cattr_accessor :start_of_week
  self.start_of_week = :monday

  attr_reader :start, :end

  # Gets the current week
  # @returns [Week] week based on current date
  def self.current
    Week.new(Date.current)
  end

  # Gets a week from a week number in the year
  # @param [integer] week_number in the year starting at 1
  # @returns [Week] week based on week number
  def self.from_week_number(week_number)
    Week.new(Date.commercial(Date.today.year, week_number, 1))
  end

  # Initializes a week in the year with start and end date
  # @param [Date] date contained within week
  def initialize(date)
    @start = date.beginning_of_week(Week.start_of_week)
    @end   = date.end_of_week(Week.start_of_week)
  end

  # Returns whether date is included in week
  # @param [Date] date to test
  # @returns [Boolean] true if contained, false otherwise
  def include?(date)
    (@start..@end).include?(date)
  end

  # Gets the week number
  # @returns [Integer] week number in year
  def number
    Week.start_of_week == :monday ?
      @start.strftime("%W").to_i :   # Starts on Monday
      @start.strftime("%U").to_i     # Starts on Sunday
  end

end
