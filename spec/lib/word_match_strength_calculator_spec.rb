require 'spec_helper'
require './lib/word_match_strength_calculator'

RSpec.describe WordMatchStrengthCalculator do
  subject { described_class.new('Deadpool') }

  context 'with exact match' do
    it 'returns 100' do
      expect(subject.calculate_match_strength('deadpool')).to eq 100
    end
  end

  context 'with no letters matching' do
    it 'returns 0' do
      expect(subject.calculate_match_strength('xyzktgf')).to eq 0
    end
  end

  context 'with half the letters matching' do
    it 'returns 50' do
      expect(subject.calculate_match_strength('deadxyzq')).to eq 50
    end
  end

  context 'with half the letters matching but out of position' do
    it 'returns 41' do
      expect(subject.calculate_match_strength('xdeadzyq')).to eq 41
    end
  end

  context 'with only first character matching at end of word' do
    it 'returns 2' do
      expect(subject.calculate_match_strength('xyxyxczd')).to eq 2
    end
  end

  context 'with all letters matching out of order' do
    it 'returns 20' do
      expect(subject.calculate_match_strength('loopdead')).to eq 20
    end
  end
end
