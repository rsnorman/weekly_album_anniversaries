class Slugger
  def self.slug(*args)
    args.map(&:underscore).join('-')
      .gsub(/\s/, '_')
      .gsub(/\//, '')
      .gsub('__', '')
      .gsub('.', '_')
  end
end
