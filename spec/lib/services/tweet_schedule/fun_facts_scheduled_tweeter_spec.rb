require 'spec_helper'
require './lib/services/tweet_schedule/fun_facts_scheduled_tweeter'

RSpec.describe TweetSchedule::FunFactsScheduledTweeter do
  describe '#tweet_all' do
    let(:artist) { double(Artist, name: 'Twin Peaks') }
    let(:album) { double(Album, name: 'Sunken', artist: artist) }
    let(:scheduled_tweet) do
      double(ScheduledTweet, album: album).tap do |st|
        allow(st).to receive(:update)
      end
    end
    let(:tweet) { double('Tweet', id: 123456789) }
    let(:fun_fact_tweeter) do
      double('FunFactsTweeter').tap do |st|
        allow(st).to receive(:tweet_about).and_return(tweet)
      end
    end

    subject do
      described_class.new(scheduled_tweets: [scheduled_tweet],
                          fun_fact_tweeter: fun_fact_tweeter)
    end

    it 'tweets scheduled tweet' do
      expect(fun_fact_tweeter)
        .to receive(:tweet_about)
        .with(scheduled_tweet.album)
      subject.tweet_all
    end

    it 'marks scheduled tweet sent with tweet ID' do
      expect(scheduled_tweet).to receive(:update).with(tweet_id: 123456789)
      subject.tweet_all
    end

    context 'with tweet not sent' do
      let(:fun_fact_tweeter) do
        double('FunFactsTweeter').tap do |st|
          allow(st).to receive(:tweet_about).and_return(nil)
        end
      end

      it 'logs warning' do
        expect(Rollbar).to receive(:warning).with(
          'No fun fact available for ' \
          "#{scheduled_tweet.album.artist.name} -" \
          " #{scheduled_tweet.album.name}")
          subject.tweet_all
      end

      it 'marks scheduld tweet failed with -1 in tweet ID' do
        expect(scheduled_tweet).to receive(:update).with(tweet_id: -1)
        subject.tweet_all
      end
    end
  end
end
