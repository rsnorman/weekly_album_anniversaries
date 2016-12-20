require 'spec_helper'
require './lib/services/lyrics/important_lyrics_formatter'

RSpec.describe Lyrics::ImportantLyricsFormatter do
  describe '#format' do
    let(:lines) do
      [
        'Last night she said',
        'Oh baby I feel so down',
        'Oh it turn me off',
        'When I feel left out',
        'So I, I turned around',
        'Oh maybe I don\'t care no more',
        'I know this for sure'
      ]
    end
    let(:max_length) { 160 }

    subject do
      described_class.new(lines, author: 'The Strokes', max_size: max_length)
    end

    context 'with no lyrics' do
      let(:lines) { [] }

      it 'returns nil' do
        expect(subject.format).to be_nil
      end
    end

    context 'with last line too long' do
      let(:lines) do
        [
          super().join(' ')
        ]
      end

      it 'returns nil' do
        expect(subject.format).to be_nil
      end
    end

    it 'returns last 4 lines with author' do
      expect(subject.format).to eq(
        "When I feel left out\n" \
        "So I, I turned around\n" \
        "Oh maybe I don't care no more\n" \
        "I know this for sure\n" \
        "- The Strokes"
      )
    end

    context 'with last 4 lines over max length' do
      let(:max_length) { 80 }

      it 'returns only lines that fit in limit' do
        expect(subject.format).to eq(
          "Oh maybe I don't care no more\n" \
          "I know this for sure\n" \
          "- The Strokes"
        )
      end
    end
  end
end
