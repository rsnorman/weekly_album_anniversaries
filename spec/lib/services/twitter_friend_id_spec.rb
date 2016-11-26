require 'spec_helper'
require './lib/services/twitter_friend_id'

RSpec.describe TwitterFriendId do
  describe '#all' do
    subject { described_class.all(twitter_client: twitter_client) }

    let(:twitter_client) do
      WistfulIndie::Twitter::Client.client.tap do |c|
        allow(c).to receive(:friend_ids).and_return [123]
      end
    end

    it 'returns all twitter friend IDs' do
      expect(subject).to eq [123]
    end
  end
end
