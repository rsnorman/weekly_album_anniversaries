# Validator that makes sure a release is in a logical range
class ReleaseDateValidator < ActiveModel::EachValidator

  DEFAULT_MAX_AGE = 120.freeze
  DEFAULT_MIN_AGE = -1.freeze

  def validate_each(record, attribute, value)
    unless (oldest_date..youngest_date).include?(value)
      record.errors[attribute] << (options[:message] || "invalid release date")
    end
  end

  private

  def oldest_date
    Date.current - (options[:max_age] || DEFAULT_MAX_AGE).years
  end

  def youngest_date
    Date.current - (options[:min_age] || DEFAULT_MIN_AGE).years
  end

end
