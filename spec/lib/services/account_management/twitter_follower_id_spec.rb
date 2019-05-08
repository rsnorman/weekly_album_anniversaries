# frozen_string_literal: true

require 'spec_helper'
require './lib/services/account_management/twitter_follower_id'

RSpec.describe AccountManagement::TwitterFollowerId do
  describe '#all' do
    subject { described_class.new(twitter_client: twitter_client) }

    let(:twitter_client) do
      WistfulIndie::Twitter::Client.client.tap do |c|
        allow(c).to receive(:follower_ids).and_return [123]
      end
    end

    it 'returns all twitter follower IDs' do
      expect(subject.all).to eq [123]
    end
  end
end
