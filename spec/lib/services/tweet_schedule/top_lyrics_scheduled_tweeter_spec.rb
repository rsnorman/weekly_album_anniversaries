require 'spec_helper'
require './lib/services/tweet_schedule/top_lyrics_scheduled_tweeter'

RSpec.describe TweetSchedule::TopLyricsScheduledTweeter do
  describe '#tweet_all' do
    let(:scheduled_tweet) do
      double(ScheduledTweet, album: double(Album)).tap do |st|
        allow(st).to receive(:update)
      end
    end
    let(:tweet) { double('Tweet', id: 123456789) }
    let(:lyrics_tweeter) do
      double('LyricTweeter').tap do |st|
        allow(st)
          .to receive(:tweet_about)
          .and_return(tweet)
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
      expect(scheduled_tweet).to receive(:update).with(tweet_id: 123456789)
      subject.tweet_all
    end
  end
end
