require 'rails_helper'

RSpec.describe BirthdayValidator do

  describe "#validate_each" do
    matcher :have_invalid_birth_date do
      match do |actual|
        actual[:errors][:birth_date].include?("invalid date of birth")
      end
    end

    let(:record)  { Hashie::Mash.new(errors: { birth_date: [] }) }
    let(:options) { { attributes: [:birth_date] } }
    subject       { BirthdayValidator.new(options) }
    before        { subject.validate_each(record, :birth_date, date) }

    context "with date older than 120 years ago" do
      let(:date) { Date.current - 121.years }
      it "should add errors to record" do
        expect(record).to have_invalid_birth_date
      end
    end

    context "with date younger than 5 years ago" do
      let(:date) { Date.current - 4.year }
      it "should add errors to record" do
        expect(record).to have_invalid_birth_date
      end
    end

    context "with date equal to 5 years" do
      let(:date) { Date.current - 5.years }
      it "should not add errors to record" do
        expect(record).to_not have_invalid_birth_date
      end
    end

    context "with date equal to 120 years" do
      let(:date) { Date.current - 120.years }
      it "should not add errors to record" do
        expect(record).to_not have_invalid_birth_date
      end
    end

    context "with custom max age" do
      let(:options) { { attributes: [:birth_date], max_age: 55 } }
      let(:date)    { Date.current - 56.years }
      it "should add errors to record" do
        expect(record).to have_invalid_birth_date
      end
    end

    context "with custom min age" do
      let(:options) { { attributes: [:birth_date], min_age: 12 } }
      let(:date)    { Date.current - 11.years }
      it "should add errors to record" do
        expect(record).to have_invalid_birth_date
      end
    end
  end

end
