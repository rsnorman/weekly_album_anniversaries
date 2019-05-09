# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Anniversary do
  around      { |ex| Timecop.freeze(Date.parse(today)) { ex.run } }
  let(:date)  { '1984-11-22' }
  let(:today) { '2015-11-20' }
  subject     { Anniversary.new(Date.parse(date)) }

  describe '#current' do
    it 'should return the current anniversary' do
      expect(subject.current).to eq Date.parse('2015-11-22')
    end

    context 'with date at the end of the year' do
      let(:today) { '2015-12-29' }

      context 'with anniversary this year' do
        let(:date) { '2015-12-29' }

        it 'should return the current anniversary' do
          expect(subject.current).to eq Date.parse('2015-12-29')
        end
      end

      context 'with anniversary next year' do
        let(:date) { '1984-1-1' }

        it 'should return the current anniversary' do
          expect(subject.current).to eq Date.parse('2016-1-1')
        end
      end
    end
  end

  describe '#count' do
    it 'should return number of anniversaries' do
      expect(subject.count).to eq 31
    end

    context 'with anniversary this week but already passed' do
      let(:today) { '2015-11-23' }
      it 'should return number of anniversaries' do
        expect(subject.count).to eq 31
      end
    end
  end

  describe '#<=>' do
    let(:anniversary)       { Anniversary.new(Date.parse('1984-11-22')) }
    let(:other_anniversary) { Anniversary.new(Date.parse(date)) }

    context 'with current anniversary count less than other anniversary count' do
      let(:date) { '1992-11-23' }
      it 'should return -1' do
        expect(anniversary <=> other_anniversary).to eq(-1)
      end
    end

    context 'with current anniversary count equal to other anniversary count' do
      let(:date) { '1984-11-22' }
      it 'should return 0' do
        expect(anniversary <=> other_anniversary).to eq 0
      end
    end

    context 'with current anniversary count greater than other anniversary count' do
      let(:date) { '1983-11-21' }
      it 'should return 1' do
        expect(anniversary <=> other_anniversary).to eq 1
      end
    end
  end
end
