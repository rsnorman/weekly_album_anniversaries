require 'spec_helper'
require './lib/services/top_song_tweet_scheduler'

RSpec.describe TopSongTweetScheduler do
  describe '#schedule_all' do
    let(:album) { double('Album') }
    let(:scheduled_at) { Time.current + (1..5).to_a.sample.days }
    let(:random_week_date) { double('random_week_date', create: scheduled_at) }

    subject do
      described_class.new(albums: [album],
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
