# frozen_string_literal: true

require 'spec_helper'
require './lib/services/tweet_schedule/top_lyrics_scheduled_tweeter'

RSpec.describe TweetSchedule::TopLyricsScheduledTweeter do
  describe '#tweet_all' do
    let(:artist) { double(Artist, name: 'Twin Peaks') }
    let(:album) { double(Album, name: 'Sunken', artist: artist) }
    let(:scheduled_tweet) do
      double(ScheduledTweet, album: album).tap do |st|
        allow(st).to receive(:update)
      end
    end
    let(:tweet) { double('Tweet', id: 123_456_789) }
    let(:lyrics_tweeter) do
      double('LyricTweeter').tap do |st|
        allow(st).to receive(:tweet_about).and_return(tweet)
      end
    end

    subject do
      described_class.new(scheduled_tweets: [scheduled_tweet],
                          lyrics_tweeter: lyrics_tweeter)
    end

    it 'tweets scheduled tweet' do
      expect(lyrics_tweeter)
        .to receive(:tweet_about)
        .with(scheduled_tweet.album)
      subject.tweet_all
    end

    it 'marks scheduled tweet sent with tweet ID' do
      expect(scheduled_tweet).to receive(:update).with(tweet_id: 123_456_789)
      subject.tweet_all
    end

    context 'with tweet not sent' do
      let(:lyrics_tweeter) do
        double('LyricTweeter').tap do |st|
          allow(st).to receive(:tweet_about).and_return(nil)
        end
      end

      it 'logs warning' do
        expect(Rollbar).to receive(:warning).with(
          'Could not find top lyrics',
          artist: scheduled_tweet.album.artist.name,
          album: scheduled_tweet.album.name
        )
        subject.tweet_all
      end

      it 'marks scheduld tweet failed with -1 in tweet ID' do
        expect(scheduled_tweet).to receive(:update).with(tweet_id: -1)
        subject.tweet_all
      end
    end
  end
end
