# frozen_string_literal: true

require 'spec_helper'
require './lib/services/account_management/twitter_account_unfollower'

RSpec.describe AccountManagement::TwitterAccountUnfollower do
  describe '#unfollow' do
    subject do
      described_class.new(twitter_client: twitter_client,
                          accounts: ungrateful_friends)
    end

    let(:twitter_client) do
      WistfulIndie::Twitter::Client.client.tap do |c|
        allow(c).to receive(:unfollow)
      end
    end
    let(:twitter_id) { '123' }
    let(:twitter_follow) { TwitterFollow.new(twitter_id: twitter_id) }
    let(:ungrateful_friends) { [twitter_follow] }

    it 'unfollows on twitter' do
      expect(twitter_client).to receive(:unfollow).with(twitter_id.to_i)
      subject.unfollow
    end

    it 'deletes twitter follow' do
      expect(twitter_follow).to receive(:destroy)
      subject.unfollow
    end

    context 'when rate limit hit' do
      before do
        allow(twitter_client)
          .to receive(:unfollow)
          .and_raise Twitter::Error::TooManyRequests
      end

      it 'prints log message' do
        expect(Rails.logger).to receive(:error).with('Too many unfollows')
        subject.unfollow
      end
    end
  end
end
