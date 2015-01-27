require 'rails_helper'

RSpec.describe PersonBirthdayJsonDecorator do

  describe "#to_api_json" do
    let(:today)    { Date.parse("2015-11-20") }
    let(:birthday) { Date.parse("1984-11-22") }
    around         {|ex| Timecop.freeze(today) { ex.run } }
    let(:person)   { create(:person, name:          "Ryan Norman",
                                     date_of_birth:  birthday) }
    subject { JSON.parse(PersonBirthdayJsonDecorator.new(person).to_api_json) }

    it "should return name" do
      expect(subject["name"]).to eq "Ryan Norman"
    end

    it "should return date_of_birth" do
      expect(subject["date_of_birth"]).to eq birthday.to_time.to_i
    end

    it "should return age" do
      expect(subject["age"]).to eq 31
    end

    it "should return birthday" do
      expect(subject["birthday"]).to eq Date.parse("2015-11-22").to_time.to_i
    end
  end

end