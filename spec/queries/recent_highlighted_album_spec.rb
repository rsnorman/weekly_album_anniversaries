# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecentHighlightedAlbum do
  describe '#find' do
    let(:album) { FactoryBot.create(:album) }
    let!(:highlighted_album) do
      FactoryBot.create(:highlighted_album, album: album,
                                            created_at: highlighted_at)
    end

    context 'with album highlighted less than 1 hour ago' do
      let(:highlighted_at) { 59.minutes.ago }

      it 'returns album' do
        expect(subject.find).to eq album
      end
    end

    context 'with ablum highlighted more than 1 hour ago' do
      let(:highlighted_at) { 181.minutes.ago }

      it 'returns nil' do
        expect(subject.find).to be_nil
      end
    end
  end
end
