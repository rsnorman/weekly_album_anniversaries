require 'spec_helper'
require './lib/services/tweets_favoritor'

RSpec.describe TweetsFavoritor do
  describe '#favorite_all' do
    let(:client) { WistfulIndie::Twitter::Client.client }
    let(:tweet) { double('tweet') }

    subject { described_class.new(tweets: [tweet], twitter_client: client) }

    it 'favorites the tweets' do
      expect(client).to receive(:favorite).with(tweet)
      subject.favorite_all
    end
  end
end
