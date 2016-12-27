require 'rails_helper'
require './lib/services/account_growth/recent_interactor_follower'

RSpec.describe AccountGrowth::RecentInteractorFollower do
  describe '#follow_all' do
    let(:client) { WistfulIndie::Twitter::Client.client }
    let(:screen_names) { ['radiohead'] }

    subject do
      described_class.new(twitter_client: client, screen_names: screen_names)
    end

    it 'follows account' do
      expect(client).to receive(:follow).with('radiohead')
      subject.follow_all
    end

    context 'with already following account' do
      before do
        FactoryGirl.create(:twitter_follow, screen_name: screen_names.first)
      end

      it 'doesn\'t follow account' do
        expect(client).not_to receive(:follow).with('radiohead')
        subject.follow_all
      end
    end

    context 'when trying to follow system account' do
      before do
        allow(client).to receive(:follow).and_raise Twitter::Error::Forbidden
      end

      it 'silently fails' do
        expect(Rails.logger)
          .to receive(:info)
          .with('Cannot follow system account')
        subject.follow_all
      end
    end

    context 'when trying to follow missing account' do
      before do
        allow(client).to receive(:follow).and_raise Twitter::Error::NotFound
      end

      it 'silently fails' do
        expect(Rails.logger)
          .to receive(:error)
          .with('Account does not exist: radiohead')
        subject.follow_all
      end
    end
  end
end
