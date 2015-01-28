require 'spec_helper'
require './app/value_objects/profile_image'

RSpec.describe ProfileImage do

  describe "#to_s" do
    subject { ProfileImage.new("profile.jpg") }

    it "should return filepath to image" do
      expect(subject.to_s).to eq "/images/photos/profile.jpg"
    end
  end

end
