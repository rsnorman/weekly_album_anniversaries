# frozen_string_literal: true

# Value object for modeling a week in the year
class Week
  DEFAULT_START_OF_WEEK = :monday

  attr_reader :start, :end

  # Returns the name of the day that starts the week
  # @return [Symbol] name of the day
  def self.start_of_week
    @start_of_week || DEFAULT_START_OF_WEEK
  end

  # Changes start of week
  # Private so it can only be changed safely
  class << self
    attr_writer :start_of_week
  end
  private_class_method :start_of_week=

  # Safe way to set start of week
  # @param [Symbol] start_of_week day name, e.g., :monday, :sunday, etc
  # @param [Proc] block to run with start of week changed
  def self.set_start(start_of_week, &block)
    self.start_of_week = start_of_week.to_sym
    block.call
    self.start_of_week = DEFAULT_START_OF_WEEK
  end

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
    @start = date.beginning_of_week(self.class.start_of_week)
    @end   = date.end_of_week(self.class.start_of_week)
  end

  # Returns whether date is included in week
  # @param [Date] date to test
  # @returns [Boolean] true if contained, false otherwise
  def include?(date)
    range.include?(date)
  end

  # Returns range of dates contained in week
  # @returns [Range<Date>] range of dates starting at week start to week end
  def range
    @start..@end
  end

  # Gets the week number
  # @returns [Integer] week number in year
  def number
    if Week.start_of_week == :monday
      @start.cweek # Starts on Monday
    else
      (@start + 1.day).cweek # Starts on Sunday
    end
  end

  def next
    Week.new(Week.current.start + 7.days)
  end
end
