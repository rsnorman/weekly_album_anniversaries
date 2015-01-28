# Object for profile images
class ProfileImage

  # Initializes profile image from filename
  # @param [String] filename of image
  def initialize(filename)
    @filename = filename
  end

  # Returns path to image
  # @returns [String] page to image
  def to_s
    "/images/photos/#{@filename}"
  end

end
