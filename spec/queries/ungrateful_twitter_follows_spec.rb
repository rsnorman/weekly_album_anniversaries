require 'rails_helper'

RSpec.describe UngratefulTwitterFollows do
  describe '#all' do
    let(:followed_at) { Date.today - 8.days }
    let(:is_friend) { false }
    let(:artist) { nil }
    let!(:twitter_follow) do
      create(:twitter_follow, created_at: followed_at,
                              is_friend: is_friend,
                              artist: artist)
    end

    context 'when not following system account and followed a week ago' do
      it 'returns twitter follow' do
        expect(subject.all).to include twitter_follow
      end
    end

    context 'when following system account' do
      let(:is_friend) { true }

      it 'returns empty array' do
        expect(subject.all).to be_empty
      end
    end

    context 'when account is an artist' do
      let(:artist) { create(:artist) }

      it 'returns empty array' do
        expect(subject.all).to be_empty
      end
    end

    context 'when account screen name matches artist screen name' do
      before do
        create(:artist, twitter_screen_name: twitter_follow.screen_name)
      end

      it 'returns empty array' do
        expect(subject.all).to be_empty
      end
    end

    context 'when account was followed less than a week ago' do
      let(:followed_at) { Date.today - 6.days }

      it 'returns empty array' do
        expect(subject.all).to be_empty
      end
    end
  end
end
