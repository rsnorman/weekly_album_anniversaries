require 'spec_helper'
require './lib/services/tweet_schedule/tweet_scheduler'

RSpec.describe TweetSchedule::TweetScheduler do
  describe '#schedule_all' do
    let(:album) do
      double('Album', name: 'All\'s Well That Ends Well', artist_name: 'Chiodos')
    end
    let(:scheduled_at) { Time.current + (1..5).to_a.sample.days }
    let(:random_week_date) { double('random_week_date', create: scheduled_at) }

    subject do
      described_class.new(albums: [album],
                          type: 'TopSong',
                          random_week_date_creator: random_week_date)
    end

    it 'creates a scheduled tweet' do
      expect(ScheduledTweet)
        .to receive(:create)
        .with(type: 'TopSong', album: album, scheduled_at: scheduled_at)
      subject.schedule_all
    end
  end
end
