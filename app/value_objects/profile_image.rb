class ProfileImage
  def initialize(filename)
    @filename = filename
  end

  def to_s
    "/images/photos/#{@filename}"
  end
end