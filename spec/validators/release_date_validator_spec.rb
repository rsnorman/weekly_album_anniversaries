require 'rails_helper'

RSpec.describe ReleaseDateValidator do

  describe "#validate_each" do
    matcher :have_invalid_release_date do
      match do |actual|
        actual[:errors][:release_date].include?("invalid release date")
      end
    end

    let(:record)  { Hashie::Mash.new(errors: { release_date: [] }) }
    let(:options) { { attributes: [:release_date] } }
    subject       { ReleaseDateValidator.new(options) }
    before        { subject.validate_each(record, :release_date, date) }

    context "with date older than 120 years ago" do
      let(:date) { Date.current - 121.years }
      it "should add errors to record" do
        expect(record).to have_invalid_release_date
      end
    end

    context "with date 2 years in the future" do
      let(:date) { Date.current + 2.year }
      it "should add errors to record" do
        expect(record).to have_invalid_release_date
      end
    end

    context "with date equal to 1 year in the future" do
      let(:date) { Date.current + 1.years }
      it "should not add errors to record" do
        expect(record).to_not have_invalid_release_date
      end
    end

    context "with date equal to 120 years" do
      let(:date) { Date.current - 120.years }
      it "should not add errors to record" do
        expect(record).to_not have_invalid_release_date
      end
    end

    context "with custom max age" do
      let(:options) { { attributes: [:release_date], max_age: 55 } }
      let(:date)    { Date.current - 56.years }
      it "should add errors to record" do
        expect(record).to have_invalid_release_date
      end
    end

    context "with custom min age" do
      let(:options) { { attributes: [:release_date], min_age: 12 } }
      let(:date)    { Date.current - 11.years }
      it "should add errors to record" do
        expect(record).to have_invalid_release_date
      end
    end
  end

end
