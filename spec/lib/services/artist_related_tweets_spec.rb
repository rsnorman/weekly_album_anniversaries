require 'spec_helper'
require './lib/services/artist_related_tweets'

RSpec.describe ArtistRelatedTweets do
  describe '#all' do
    let(:tweet_user_id) { 123456789 }
    let(:tweets) { [double('tweet', user: double('user', id: tweet_user_id))] }
    let(:client) do
      WistfulIndie::Twitter::Client.client.tap do |c|
        allow(c)
          .to receive(:search)
          .with('Radiohead #np -rt', filter: :safe)
          .and_return tweets
      end
    end
    let(:artist) { Artist.new(name: 'Radiohead') }

    subject { described_class.new(artist: artist, twitter_client: client) }

    it 'returns related tweets' do
      expect(subject.all).to eq tweets
    end

    it 'only returns 5 related tweets' do
      expect(tweets).to receive(:take).with(5).and_call_original
      subject.all
    end

    context 'with system account tweet matching search query' do
      let(:tweet_user_id) { 704175249202540544 }

      it 'doesn\'t include in related tweets' do
        expect(subject.all).to be_empty
      end
    end
  end
end
