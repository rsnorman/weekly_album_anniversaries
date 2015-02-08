require 'rails_helper'

RSpec.describe Album do

  it "generates a token" do
    album = create(:album)
    expect(album.uuid).to_not be_nil
  end

  describe "validations" do
    let(:album) { build(:album, name: nil, release_date: nil) }

    it "should validate presence of name" do
      album.save
      expect(album).to validate_presence_of :name
    end

    it "should validate presence of release_date" do
      album.save
      expect(album).to validate_presence_of :release_date
    end

    it "should validate release_date date range" do
      album.release_date = Date.current + 2.years
      album.save
      expect(album.errors[:release_date]).to_not be_empty
    end
  end

  describe "#anniversary" do
    let(:album) { build(:album, release_date: Date.current - 20.years )}
    it "should create anniversary object with release_date" do
      expect(Anniversary).to receive(:new).with(Date.current - 20.years)
      album.anniversary
    end
  end

end
