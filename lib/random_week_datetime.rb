# frozen_string_literal: true

class RandomWeekDatetime
  def self.create
    random_day_of_week = (0..6).to_a.sample
    random_hour_in_day = (8..20).to_a.sample
    Week.current.start + random_day_of_week.days + random_hour_in_day.hours
  end
end
