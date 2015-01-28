# Models a person including their name, birthday and thumbnail image path
class Person < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :date_of_birth
  validates :date_of_birth, birthday: true

  # Returns birthday of person
  # @returns [Birthday] birthday of person
  def birthday
    @birthday ||= Birthday.new(date_of_birth)
  end

  # Returns thumbnail image of person
  # @returns [ProfileImage] profile image of person
  def thumbnail_image
    @profile_image ||= ProfileImage.new(thumbnail)
  end

end
