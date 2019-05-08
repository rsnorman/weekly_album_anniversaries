# frozen_string_literal: true

require 'spec_helper'
require './lib/services/account_management/new_twitter_friend_tracker'

RSpec.describe AccountManagement::NewTwitterFriendTracker do
  describe '#track_all' do
    subject do
      described_class.new(new_twitter_friends: new_twitter_friends,
                          follow_ids: [123])
    end

    let(:twitter_follow_creator) { TwitterFollowCreator.new }
    let(:new_twitter_friends) do
      [double('TwitterUser', id: 123, screen_name: 'radiohead')]
    end

    before do
      allow(TwitterFollowCreator)
        .to receive(:new)
        .with(twitter_id: 123, screen_name: 'radiohead', follow_ids: [123])
        .and_return twitter_follow_creator
    end

    it 'tracks new twitter friend account' do
      expect(twitter_follow_creator).to receive(:save)
      subject.track_all
    end
  end
end
