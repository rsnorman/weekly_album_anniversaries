# frozen_string_literal: true

require 'spec_helper'
require './lib/services/top_song/youtube_client'

RSpec.describe TopSong::YoutubeClient do
  describe '#find' do
    before do
      allow(OpenURI)
        .to receive(:open_uri)
        .with('https://content.googleapis.com/youtube/v3/search?' \
              "part=id,snippet&q=Radiohead+Idioteque&key=#{api_key}&" \
              'type=video&topic=/m/04rlf&maxResults=1')
        .and_return(double('Response', read: response_json.to_json))
    end

    let(:api_key) { 'garbage' }

    let(:response_json) do
      { 'items' => [{ 'id' => { 'videoId' => 'E7hvGPLexL0' } }] }
    end

    subject { described_class.new('Radiohead Idioteque', api_key: api_key) }

    it 'returns youtube url for video' do
      expect(subject.find).to eq 'https://www.youtube.com/watch?v=E7hvGPLexL0'
    end

    describe 'with no results' do
      let(:response_json) do
        { 'items' => [] }
      end

      it 'returns nil' do
        expect(subject.find).to be_nil
      end
    end
  end
end
