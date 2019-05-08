# frozen_string_literal: true

require 'spec_helper'
require './lib/services/top_song/song_tweeter'

RSpec.describe TopSong::SongTweeter do
  describe '#tweet' do
    let(:twitter_client) { WistfulIndie::Twitter::Client.client }
    let(:top_track_finder) do
      double('TopTrackFinder').tap do |ttf|
        allow(ttf).to receive(:top_for).with(album).and_return(top_track)
      end
    end
    let(:song_url_finder) do
      double('SongUrlFinder').tap do |suf|
        allow(suf)
          .to receive(:find)
          .with("Animal Collective #{top_track && top_track.name}")
          .and_return('https://www.youtube.com/watch?v=WSmuzEzeAeY')
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
                          twitter_client: twitter_client,
                          song_url_finder: song_url_finder)
    end

    it 'creates tweet about song with youtube link' do
      expect(twitter_client).to receive(:update).with(
        '"What Would I Want? Sky" by @anmlcollective is still great ' \
        'after 7 years https://www.youtube.com/watch?v=WSmuzEzeAeY ' \
        '#AnimalCollective #indie #np'
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

    context 'with no twitter screen name' do
      before do
        artist.twitter_screen_name = nil
      end

      it 'creates youtube link tweet without artist screenname' do
        expect(twitter_client).to receive(:update).with(
          '"What Would I Want? Sky" by Animal Collective is still great ' \
          'after 7 years https://www.youtube.com/watch?v=WSmuzEzeAeY ' \
          '#AnimalCollective #indie #np'
        )
        subject.tweet
      end
    end

    context 'with twitter screen name blank' do
      before do
        artist.twitter_screen_name = ''
      end

      it 'creates youtube link tweet without artist screenname' do
        expect(twitter_client).to receive(:update).with(
          '"What Would I Want? Sky" by Animal Collective is still great ' \
          'after 7 years https://www.youtube.com/watch?v=WSmuzEzeAeY ' \
          '#AnimalCollective #indie #np'
        )
        subject.tweet
      end
    end
  end
end
