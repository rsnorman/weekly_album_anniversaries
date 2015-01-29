require 'rails_helper'

RSpec.describe Person do

  it "generates a token" do
    person = create(:person)
    expect(person.uuid).to_not be_nil
  end

  describe "validations" do
    let(:person) { build(:person, name: nil, date_of_birth: nil) }

    it "should validate presence of name" do
      person.save
      expect(person).to validate_presence_of :name
    end

    it "should validate presence of date_of_birth" do
      person.save
      expect(person).to validate_presence_of :date_of_birth
    end

    it "should validate date_of_birth date range" do
      person.date_of_birth = Date.current
      person.save
      expect(person.errors[:date_of_birth]).to_not be_empty
    end
  end

  describe "#birthday" do
    let(:person) { build(:person, date_of_birth: Date.current - 20.years )}
    it "should create birthday object with date_of_birth" do
      expect(Birthday).to receive(:new).with(Date.current - 20.years)
      person.birthday
    end
  end

end
