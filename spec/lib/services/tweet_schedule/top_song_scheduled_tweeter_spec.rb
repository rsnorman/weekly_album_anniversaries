require 'spec_helper'
require './lib/services/tweet_schedule/top_song_scheduled_tweeter'

RSpec.describe TweetSchedule::TopSongScheduledTweeter do
  describe '#tweet_all' do
    let(:scheduled_tweet) do
      double(ScheduledTweet, album: double(Album)).tap do |st|
        allow(st).to receive(:update)
      end
    end
    let(:tweet) { double('Tweet', id: 123456789) }
    let(:song_tweeter) do
      double('SongTweet').tap do |st|
        allow(st)
          .to receive(:tweet_about)
          .and_return(tweet)
      end
    end

    subject do
      described_class.new(scheduled_tweets: [scheduled_tweet],
                          song_tweeter: song_tweeter)
    end

    it 'tweets scheduled tweet' do
      expect(song_tweeter)
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
