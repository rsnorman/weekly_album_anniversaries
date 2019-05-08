# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScheduledAtValidator do
  describe '#validate' do
    let(:artist) { Artist.new(name: 'Nick Cave & The Bad Seeds') }
    let(:album) { Album.new(name: 'Dig, Lazarus, Dig!!!', artist: artist) }
    let(:type) { 'TopSong' }
    let(:scheduled_at) { Time.current }
    let(:scheduled_tweet) do
      ScheduledTweet.new(scheduled_at: scheduled_at,
                         album: album,
                         type: type)
    end

    subject { described_class.new.validate(scheduled_tweet) }

    context 'with no tweets scheduled this week for album and type' do
      it 'adds no errors' do
        subject
        expect(scheduled_tweet.errors[:scheduled_at]).to be_empty
      end
    end

    context 'with tweet scheduled this week for album and type' do
      before do
        ScheduledTweet.create(scheduled_at: scheduled_at,
                              album: album,
                              type: type)
      end

      it 'adds already scheduled error' do
        subject
        expect(scheduled_tweet.errors[:scheduled_at]).not_to be_empty
      end
    end

    context 'with scheduled tweet already saved' do
      before { scheduled_tweet.save }

      it 'adds no errors' do
        subject
        expect(scheduled_tweet.errors[:scheduled_at]).to be_empty
      end
    end
  end
end
