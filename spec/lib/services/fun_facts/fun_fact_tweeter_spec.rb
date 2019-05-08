# frozen_string_literal: true

require 'spec_helper'
require './lib/services/top_song/song_tweeter'

RSpec.describe FunFacts::FunFactTweeter do
  describe '#tweet' do
    let(:twitter_client) { WistfulIndie::Twitter::Client.client }
    let(:artist) do
      Artist.new(name: 'Animal Collective',
                 twitter_screen_name: 'anmlcollective')
    end
    let(:album) { Album.new(artist: artist, name: 'Fall Be Kind', release_date: 7.years.ago, fun_fact: fun_fact) }
    let(:fun_fact) { FunFact.new(description: '[twitter]\'s "What Would I Want? Sky" on [album] features the first ever licensed Grateful Dead sample') }

    subject do
      described_class.new(album: album, twitter_client: twitter_client)
    end

    it 'creates tweet about an album fun fact' do
      expect(twitter_client).to receive(:update).with(
        '@anmlcollective\'s "What Would I Want? Sky" on "Fall Be Kind" features the first ever licensed Grateful Dead sample'
      )
      subject.tweet
    end

    context 'with no fun fact' do
      let(:fun_fact) { nil }

      it 'doesn\'t tweet song' do
        expect(twitter_client).not_to receive(:update)
        subject.tweet
      end
    end
  end
end
