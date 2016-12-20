require 'spec_helper'
require './lib/services/song_tweeter'

RSpec.describe SongTweeter do
  describe '#tweet' do
    let(:twitter_client) { WistfulIndie::Twitter::Client.client }
    let(:top_track_finder) do
      TopAlbumTrack.tap do |tat|
        allow(tat)
          .to receive(:new)
          .and_return(double('TopTrackFinder', top: top_track))
      end
    end

    let(:top_track) do
      double(
        'Track',
         name: 'What Would I Want? Sky',
         external_urls: {
           'spotify' => 'https://open.spotify.com/track/3OzBfEIRte9W7pUnrN64aL'
         }
      )
    end
    let(:artist) do
      Artist.new(name: 'Animal Collective',
                 twitter_screen_name: 'anmlcollective')
    end
    let(:album) { Album.new(artist: artist, release_date: 7.years.ago) }


    subject do
      described_class.new(album: album,
                          top_track_finder: top_track_finder,
                          twitter_client: twitter_client)
    end

    it 'creates tweet about song with spotify link' do
      expect(twitter_client).to receive(:update).with(
        ".@anmlcollective's song \"What Would I Want? Sky\" is still great " \
        "after 7 years https://open.spotify.com/track/3OzBfEIRte9W7pUnrN64aL " \
        "#AnimalCollective #indiemusic"
      )
      subject.tweet
    end

    context 'with no top track' do
      let(:top_track) { nil }

      it 'doesn\'t tweet song' do
        expect(twitter_client).not_to receive(:update)
        subject.tweet
      end
    end
  end
end
