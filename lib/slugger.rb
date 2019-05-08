# frozen_string_literal: true

class Slugger
  def self.slug(*args)
    args.compact.map(&:underscore).join('-')
        .gsub(/\s/, '_')
        .gsub(%r{/}, '')
        .gsub('__', '')
        .tr('.', '_')
  end
end
