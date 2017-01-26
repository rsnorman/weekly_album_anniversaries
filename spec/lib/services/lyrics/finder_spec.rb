require 'spec_helper'
require './lib/services/lyrics/finder'

RSpec.describe Lyrics::Finder do
  describe '#find' do
    let(:track) { double('Track', name: 'Last Nite', artist: 'The Strokes') }
    let(:parser) do
      double('Parser').tap do |p|
        allow(p)
          .to receive(:parse)
          .with("Last night she said\nOh baby I feel so down")
          .and_return(['Last night she said',
                       'Oh baby I feel so down'])
      end
    end
    let(:results) do
      [
        double('Result1', primary_artist: double('Artist', name: 'Other Artist')),
        double('Result2', primary_artist: double('Artist2', name: 'The STROKES'),
                          url: 'http://lyrics.strokes.com')
      ]
    end


    before do
      allow(Genius::Song)
        .to receive(:search)
        .with('Last Nite')
        .and_return(results)
      allow(OpenURI)
        .to receive(:open_uri)
        .with('http://lyrics.strokes.com')
        .and_return(
          "<div class='lyrics'>Last night she said<br />\n" \
          'Oh baby I feel so down</div>'
        )
    end

    subject { described_class.new(track, lyrics_parser: parser) }

    context 'when unable to find lyrics' do
      let(:results) { [] }

      it 'returns nil' do
        expect(subject.find).to be_nil
      end
    end

    it 'returns lines of lyrics' do
      expect(subject.find).to eq(['Last night she said',
                                  'Oh baby I feel so down'])
    end
  end
end
