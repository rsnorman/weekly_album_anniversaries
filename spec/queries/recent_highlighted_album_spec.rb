require 'rails_helper'

RSpec.describe RecentHighlightedAlbum do
  describe '#find' do
    let(:album) { FactoryGirl.create(:album) }
    let!(:highlighted_album) do
      FactoryGirl.create(:highlighted_album, album: album,
                                             created_at: highlighted_at)
    end

    context 'with album highlighted less than 1 hour ago' do
      let(:highlighted_at) { 59.minutes.ago }

      it 'returns album' do
        expect(subject.find).to eq album
      end
    end

    context 'with ablum highlighted more than 1 hour ago' do
      let(:highlighted_at) { 61.minutes.ago }

      it 'returns nil' do
        expect(subject.find).to be_nil
      end
    end
  end
end
