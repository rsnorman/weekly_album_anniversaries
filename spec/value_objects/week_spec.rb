require 'rails_helper'

RSpec.describe Week do

  before { Week.start_of_week = :monday }

  describe ".current" do
    around {|ex| Timecop.freeze("2015-1-1") { ex.run } }
    subject { Week.current }

    it "should return current week" do
      expect(subject.start).to eq Date.parse("2014-12-29")
      expect(subject.end).to   eq Date.parse("2015-1-4")
    end
  end

  describe ".from_week_number" do
    around {|ex| Timecop.freeze("2015-1-1") { ex.run } }
    it "should return first week" do
      expect(Week.from_week_number(1).start).to eq Date.parse("2014-12-29")
    end

    it "should return last week" do
      expect(Week.from_week_number(52).start).to eq Date.parse("2015-12-21")
    end
  end

  describe "#initialize" do
    subject { Week.new(Date.parse("2015-1-27")) }

    context "with start of week on monday" do
      before { Week.start_of_week = :monday }
      it "should set start to monday" do
        expect(subject.start).to eq Date.parse("2015-1-26")
      end

      it "should set end to next sunday" do
        expect(subject.end).to eq Date.parse("2015-2-1")
      end
    end

    context "with start of week on sunday" do
      before { Week.start_of_week = :sunday }
      it "should set start to sunday" do
        expect(subject.start).to eq Date.parse("2015-1-25")
      end

      it "should set end to next saturday" do
        expect(subject.end).to eq Date.parse("2015-1-31")
      end
    end
  end

  describe "number" do
    context "with monday as start of week" do
      around {|ex| Timecop.freeze("2015-1-26") { ex.run } }
      before { Week.start_of_week = :monday }

      context "with monday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today).number).to eq 4
        end
      end

      context "with sunday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today - 1.day).number).to eq 3
        end
      end
    end

    context "with sunday as start of week" do
      around {|ex| Timecop.freeze("2015-1-25") { ex.run } }
      before { Week.start_of_week = :sunday }

      context "with sunday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today).number).to eq 4
        end
      end

      context "with saturday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today - 1.day).number).to eq 3
        end
      end
    end
  end

  describe "#include?" do
    subject { Week.new(Date.parse("2015-1-29")).include?(Date.parse(date)) }

    context "with date before week start" do
      let(:date) { "2015-1-25" }
      it "should return false" do
        expect(subject).to be_falsey
      end
    end

    context "with date equal to week start" do
      let(:date) { "2015-1-26" }
      it "should return true" do
        expect(subject).to be_truthy
      end
    end

    context "with date equal to week end" do
      let(:date) { "2015-2-1" }
      it "should return true" do
        expect(subject).to be_truthy
      end
    end

    context "with date after week end" do
      let(:date) { "2015-2-2" }
      it "should return false" do
        expect(subject).to be_falsey
      end
    end
  end
end
