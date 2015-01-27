require 'rails_helper'

RSpec.describe WeeklyBirthdayQuery do
  def get_birthdate(age, day_of_week)
    monday = Date.today.beginning_of_week
    (monday + day_of_week.days) - age.years
  end

  describe "#find_all" do
    let(:query)      { WeeklyBirthdayQuery.new }
    let(:birth_date) { Date.today - 45.years }
    subject          { query.find_all }
    let!(:person)    { create(:person, date_of_birth: birth_date) }

    context "with all birthdays before this week" do
      let(:birth_date) { get_birthdate(30, -1) }
      it "should return empty array" do
        expect(subject).to be_empty
      end
    end

    context "with birthday at the start of the week" do
      let(:birth_date) { get_birthdate(30, 0) }
      it "should return person with birthday" do
        expect(subject).to include(person)
      end
    end

    context "with birthday at the end of the week" do
      let(:birth_date) { get_birthdate(30, 6) }
      it "should return person with birthday" do
        expect(subject).to include(person)
      end
    end

    context "with multiple birthdays" do
      let(:birth_date) { get_birthdate(30, 6) }
      let!(:person2)   { create(:person, date_of_birth: get_birthdate(18, 0)) }
      it "should return people with birthdays" do
        expect(subject).to include(person)
        expect(subject).to include(person2)
      end
    end

    context "with all birthdays after this week" do
      let(:birth_date) { get_birthdate(30, 7) }
      it "should return empty array" do
        expect(subject).to be_empty
      end
    end

    context "with combined query" do
      let!(:png_person)  { create(:person, thumbnail: "image.png") }
      let!(:jpg_person)  { create(:person, thumbnail: "image.jpg") }
      let(:jpg_relation) { Person.where("thumbnail LIKE ?", "%.jpg") }
      let(:query)        { WeeklyBirthdayQuery.new(jpg_relation) }

      it "should return only people with weekly birthdays and jpg thumbnails" do
        expect(subject).to include(jpg_person)
        expect(subject).to_not include(png_person)
      end
    end
  end

end
