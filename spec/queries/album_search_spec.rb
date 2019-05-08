# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlbumSearch do
  describe '#search' do
    let!(:artist) { FactoryBot.create(:artist, name: 'Radiohead') }
    let!(:album) { FactoryBot.create(:album, artist: artist, name: 'The Bends') }

    subject { described_class.new }

    context 'with not matching artist or album' do
      it 'returns an empty array' do
        expect(subject.search('BADQUERY')).to be_empty
      end
    end

    context 'with matching album name' do
      it 'returns the matching album' do
        expect(subject.search('The Bends')).to include album
      end
    end

    context 'with matching artist name' do
      it 'returns the artist\'s album' do
        expect(subject.search('Radiohead')).to include album
      end
    end

    context 'with matching part of album name' do
      it 'returns the matching album' do
        expect(subject.search('Bend')).to include album
      end
    end

    context 'with matching part of artist name' do
      it 'returns the matching album' do
        expect(subject.search('ADIOHE')).to include album
      end
    end

    context 'with fuzzy matching album name' do
      it 'returns the matching album' do
        expect(subject.search('The Rends')).to include album
      end
    end

    context 'with fuzzy matching artist name' do
      it 'returns the matching album' do
        expect(subject.search('Ladiodeal')).to include album
      end
    end
  end
end
