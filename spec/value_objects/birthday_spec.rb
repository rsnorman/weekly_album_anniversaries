require 'rails_helper'

RSpec.describe Birthday do
  around      {|ex| Timecop.freeze(Date.parse(today)) { ex.run } }
  let(:date)  { "1984-11-22" }
  let(:today) { "2015-11-20" }
  subject     { Birthday.new(Date.parse(date)) }

  describe "#current" do
    it "should return the current birthday" do
      expect(subject.current).to eq Date.parse('2015-11-22')
    end

    context "with date at the end of the year" do
      let(:today) { "2015-12-29" }

      context "with birthday this year" do
        let(:date) { "2015-12-29" }

        it "should return the current birthday" do
          expect(subject.current).to eq Date.parse('2015-12-29')
        end
      end

      context "with birthday next year" do
        let(:date) { "1984-1-1" }

        it "should return the current birthday" do
          expect(subject.current).to eq Date.parse('2016-1-1')
        end
      end
    end
  end

  describe "#count" do
    it "should return number of birthdays" do
      expect(subject.count).to eq 31
    end

    context "with birthday this week but already passed" do
      let(:today) { "2015-11-23" }
      it "should return number of birthdays" do
        expect(subject.count).to eq 31
      end
    end
  end

  describe "#<=>" do
    let(:birthday)       { Birthday.new(Date.parse("1984-11-22")) }
    let(:other_birthday) { Birthday.new(Date.parse(date)) }

    context "with current birthday less than other birthday" do
      let(:date) { "1991-11-23" }
      it "should return -1" do
        expect(birthday <=> other_birthday).to eq -1
      end
    end

    context "with current birthday equal to other birthday" do
      let(:date) { "1991-11-22" }
      it "should return 0" do
        expect(birthday <=> other_birthday).to eq 0
      end
    end

    context "with current birthday greater than other birthday" do
      let(:date) { "1983-11-21" }
      it "should return 1" do
        expect(birthday <=> other_birthday).to eq 1
      end
    end
  end

end
