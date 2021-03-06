# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActiveScheduledTweet do
  describe '#all' do
    let!(:tweet) do
      FactoryBot.create(:scheduled_tweet, scheduled_at: scheduled_at)
    end

    context 'with tweet to be sent more than 5 minutes ago' do
      let(:scheduled_at) { 6.minutes.ago }

      it 'returns scheduled tweets' do
        expect(subject.all).to include tweet
      end
    end

    context 'with tweet to be sent 5 minutes ago' do
      let(:scheduled_at) { 5.minutes.ago }

      it 'returns scheduled tweets' do
        expect(subject.all).to include tweet
      end
    end

    context 'with tweet to be sent 5 from now' do
      let(:scheduled_at) { 5.minutes.from_now }

      it 'returns scheduled tweets' do
        expect(subject.all).to include tweet
      end
    end

    context 'with tweet to be sent more than 5 minutes from now' do
      let(:scheduled_at) { 6.minutes.from_now }

      it 'returns no scheduled tweets' do
        expect(subject.all).to be_empty
      end
    end

    context 'with tweet already tied to scheduled tweet' do
      let(:scheduled_at) { 5.minutes.from_now }

      before { tweet.update!(tweet_id: 123_456_789) }

      it 'returns no scheduled tweets' do
        expect(subject.all).to be_empty
      end
    end
  end
end
