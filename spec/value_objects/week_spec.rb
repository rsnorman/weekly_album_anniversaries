require 'rails_helper'

RSpec.describe Week do

  describe ".current" do
    around {|ex| Timecop.freeze("Thu, 1 Jan 2015 00:00:00 UTC") { ex.run } }
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

  describe ".set_start" do
    it "should set the week start in the block" do
      Week.set_start(:tuesday) do
        expect(Week.start_of_week).to eq :tuesday
      end
    end

    it "should set week back to default week start after block" do
      Week.set_start(:tuesday) {}
      expect(Week.start_of_week).to eq Week::DEFAULT_START_OF_WEEK
    end
  end

  describe "start_of_week" do
    context "with week start never set" do
      before { Week.instance_variable_set("@start_of_week", nil)}
      it "should use default value" do
        expect(Week.start_of_week).to eq Week::DEFAULT_START_OF_WEEK
      end
    end

    context "with week start set" do
      around {|ex| Week.set_start(:wednesday) { ex.run }}
      it "should use default value" do
        expect(Week.start_of_week).to eq :wednesday
      end
    end
  end

  describe "start_of_week=" do
    it "should raise exception if attempted to set" do
      expect { Week.start_of_week = :thursday }.to raise_exception NoMethodError
    end
  end

  describe "#initialize" do
    subject { Week.new(Date.parse("2015-1-27")) }

    context "with start of week on monday" do
      around {|ex| Week.set_start(:monday) { ex.run } }
      it "should set start to monday" do
        expect(subject.start).to eq Date.parse("2015-1-26")
      end

      it "should set end to next sunday" do
        expect(subject.end).to eq Date.parse("2015-2-1")
      end
    end

    context "with start of week on sunday" do
      around {|ex| Week.set_start(:sunday) { ex.run } }
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
      around {|ex| Week.set_start(:monday) { ex.run } }

      context "with monday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today).number).to eq 5
        end
      end

      context "with sunday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today - 1.day).number).to eq 4
        end
      end
    end

    context "with sunday as start of week" do
      around {|ex| Timecop.freeze("2015-1-25") { ex.run } }
      around {|ex| Week.set_start(:sunday) { ex.run } }

      context "with sunday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today).number).to eq 5
        end
      end

      context "with saturday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today - 1.day).number).to eq 4
        end
      end
    end

    context 'with week starting before new year' do
      around {|ex| Timecop.freeze("2019-1-1") { ex.run } }
      around {|ex| Week.set_start(:monday) { ex.run } }

      context "with monday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today).number).to eq 1
        end
      end

      context "with next monday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today + 7.days).number).to eq 2
        end
      end
    end

    context 'with week starting after new year' do
      around {|ex| Timecop.freeze("2018-1-1") { ex.run } }
      around {|ex| Week.set_start(:monday) { ex.run } }

      context "with monday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today).number).to eq 1
        end
      end

      context "with next monday" do
        it "should return number of week in year" do
          expect(Week.new(Date.today + 7.days).number).to eq 2
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
