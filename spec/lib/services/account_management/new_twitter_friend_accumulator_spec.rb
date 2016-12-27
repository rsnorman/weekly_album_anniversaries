require 'spec_helper'
require './lib/services/account_management/new_twitter_friend_accumulator'

RSpec.describe AccountManagement::NewTwitterFriendAccumulator do
  describe '#all' do
    subject do
      described_class.new(twitter_friend_ids: twitter_friend_ids,
                          current_follows: current_follows,
                          twitter_client: twitter_client)
    end

    let(:twitter_friend_ids) { [123] }
    let(:current_follows) do
      double('CurrentFollows').tap do |cf|
        allow(cf)
          .to receive(:pluck)
          .with(:twitter_id)
          .and_return current_follow_ids
      end
    end
    let(:current_follow_ids) { [] }
    let(:twitter_client) do
      WistfulIndie::Twitter::Client.client.tap do |c|
        allow(c).to receive(:user).with(123).and_return twitter_account
      end
    end
    let(:twitter_account) { double('TwitterAccount') }

    it 'returns all new twitter friend accounts' do
      expect(subject.all).to eq [twitter_account]
    end

    context 'with account friend already tracked' do
      let(:current_follow_ids) { ['123'] }

      it 'returns empty array' do
        expect(subject.all).to be_empty
      end
    end
  end
end
