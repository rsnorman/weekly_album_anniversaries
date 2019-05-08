# frozen_string_literal: true

require 'rails_helper'
require './lib/services/account_management/twitter_friend_updater'

RSpec.describe AccountManagement::TwitterFriendUpdater do
  describe '#update' do
    let(:follow_ids) { [123] }
    let!(:twitter_follow) { create(:twitter_follow, twitter_id: 123) }

    subject { described_class.new(follow_ids: follow_ids) }

    context 'with account that has followed back' do
      it 'sets as a friend' do
        expect_any_instance_of(TwitterFollow)
          .to receive(:update).with(is_friend: true)
        subject.update
      end
    end

    context 'with account that hasn\'t followed back' do
      let(:follow_ids) { [987] }

      it 'doesn\'t set as a friend' do
        expect_any_instance_of(TwitterFollow)
          .not_to receive(:update).with(is_friend: true)
        subject.update
      end
    end

    context 'with account that is already marked as friend' do
      let!(:twitter_follow) do
        create(:twitter_follow, :friend, twitter_id: 123)
      end

      it 'doesn\'t set as a friend' do
        expect_any_instance_of(TwitterFollow)
          .not_to receive(:update).with(is_friend: true)
        subject.update
      end
    end
  end
end
