require 'rails_helper'

RSpec.describe TwitterFollowCreator do
  describe '#save' do
    subject { described_class.new(twitter_id: 123, screen_name: 'rsnorman') }

    it 'creates a twitter follow' do
      expect(TwitterFollow)
        .to receive(:create)
        .with(twitter_id: 123,
              screen_name: 'rsnorman',
              is_friend: false,
              artist: nil)
      subject.save
    end

    context 'with account following system account' do
      subject do
        described_class.new(twitter_id: 123,
                            screen_name: 'rsnorman',
                            follower_ids: [123]
                           )
      end

      it 'creates a twitter follow' do
        expect(TwitterFollow)
          .to receive(:create)
          .with(twitter_id: 123,
                screen_name: 'rsnorman',
                is_friend: true,
                artist: nil)
        subject.save
      end
    end

    context 'with artist tied to twitter account' do
      let(:artist) { FactoryGirl.create(:artist, twitter_screen_name: 'rsnorman') }

      it 'creates a twitter follow' do
        expect(TwitterFollow)
          .to receive(:create)
          .with(twitter_id: 123,
                screen_name: 'rsnorman',
                is_friend: false,
                artist: artist)
        subject.save
      end
    end
  end
end
