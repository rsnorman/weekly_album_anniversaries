# frozen_string_literal: true

require 'spec_helper'
require './lib/services/lyrics/lyrics_tweeter'

RSpec.describe Lyrics::LyricsTweeter do
  describe '#tweet' do
    let(:twitter_client) { WistfulIndie::Twitter::Client.client }
    let(:top_track_finder) do
      double('TopTrackFinder').tap do |ttf|
        allow(ttf).to receive(:top_for).with(album).and_return(top_track)
      end
    end

    let(:top_track) { double('Track', name: 'What Would I Want? Sky') }
    let(:artist) do
      Artist.new(name: 'Animal Collective',
                 twitter_screen_name: 'anmlcollective')
    end
    let(:album) { Album.new(artist: artist, release_date: 7.years.ago) }
    let(:lyrics) { ['What would I want? Sky'] }
    let(:lyrics_finder) { double('LyricsFinder', find: lyrics) }
    let(:lyrics_formatter_class) do
      double('LyricsFormatterClass').tap do |lfc|
        allow(lfc)
          .to receive(:new)
          .with(lyrics, author: quoter)
          .and_return(lyrics_formatter)
      end
    end
    let(:lyrics_formatter) do
      double('LyricsFormatter',
             format: "What would I want? Sky\n- #{quoter}")
    end

    let(:quoter) do
      if artist.twitter_screen_name && artist.twitter_screen_name != ''
        "@#{artist.twitter_screen_name}"
      else
        artist.name
      end
    end

    subject do
      described_class.new(album: album,
                          top_track_finder: top_track_finder,
                          twitter_client: twitter_client,
                          lyrics_finder: lyrics_finder,
                          lyrics_formatter: lyrics_formatter_class)
    end

    it 'creates tweet with lyrics from top song' do
      expect(twitter_client).to receive(:update).with(
        "What would I want? Sky\n- @anmlcollective"
      )
      subject.tweet
    end

    context 'with no twitter screen name' do
      before do
        artist.twitter_screen_name = nil
      end

      it 'creates tweet with lyric and no twitter screen name' do
        expect(twitter_client).to receive(:update).with(
          "What would I want? Sky\n- Animal Collective"
        )
        subject.tweet
      end
    end

    context 'with twitter screen name blank' do
      before do
        artist.twitter_screen_name = ''
      end

      it 'creates tweet with lyric and no twitter screen name' do
        expect(twitter_client).to receive(:update).with(
          "What would I want? Sky\n- Animal Collective"
        )
        subject.tweet
      end
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
