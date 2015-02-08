require 'rails_helper'

RSpec.describe WeeklyAnniversaryQuery do
  def get_release_date(age, day_of_week)
    monday = Date.today.beginning_of_week
    (monday + day_of_week.days) - age.years
  end

  describe "#find_all" do
    let(:query)        { WeeklyAnniversaryQuery.new }
    let(:release_date) { Date.today - 4.years }
    subject            { query.find_all }
    let!(:album)       { create(:album, name: "The Monitor",
                                        artist: "Titus Andronicus",
                                        release_date: release_date) }

    context "with all Anniversaries before this week" do
      let(:release_date) { get_release_date(3, -1) }
      it "should return empty array" do
        expect(subject).to be_empty
      end
    end

    context "with Anniversary at the start of the week" do
      let(:release_date) { get_release_date(3, 0) }
      it "should return album with Anniversary" do
        expect(subject).to include(album)
      end
    end

    context "with Anniversary at the end of the week" do
      let(:release_date) { get_release_date(3, 6) }
      it "should return album with Anniversary" do
        expect(subject).to include(album)
      end
    end

    context "with multiple Anniversaries" do
      let(:release_date) { get_release_date(3, 6) }
      let!(:album2)   { create(:album, release_date: get_release_date(18, 0)) }
      it "should return albums with Anniversaries" do
        expect(subject).to include(album)
        expect(subject).to include(album2)
      end

      it "should sort them based on current Anniversary" do
        album2.release_date = album.release_date - 1.days
        expect(subject.first).to eq album2
        expect(subject.last).to eq album
      end
    end

    context "with all Anniversaries after this week" do
      let(:release_date) { get_release_date(3, 7) }
      it "should return empty array" do
        expect(subject).to be_empty
      end
    end

    context "with combined query" do
      let!(:png_album)  { create(:album, thumbnail: "image.png") }
      let!(:jpg_album)  { create(:album, thumbnail: "image.jpg") }
      let(:jpg_relation) { Album.where("thumbnail LIKE ?", "%.jpg") }
      let(:query)        { WeeklyAnniversaryQuery.new(jpg_relation) }

      it "should return only albums with weekly Anniversaries and jpg thumbnails" do
        expect(subject).to include(jpg_album)
        expect(subject).to_not include(png_album)
      end
    end
  end

end
