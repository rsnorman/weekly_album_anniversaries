require 'rails_helper'

RSpec.describe Genre do

  it "generates a token" do
    genre = create(:genre)
    expect(genre.uuid).to_not be_nil
  end

  describe "validations" do
    let(:genre) { build(:genre, name: nil) }

    it "should validate presence of name" do
      genre.save
      expect(genre).to validate_presence_of :name
    end
  end

end
