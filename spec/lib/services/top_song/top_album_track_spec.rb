# frozen_string_literal: true

require 'rails_helper'
require './lib/services/top_song/top_album_track'

RSpec.describe TopSong::TopAlbumTrack do
  describe '#top' do
    let(:top_track) { double('TopSpotifyTrack', popularity: 999) }
    let(:artist) { Artist.new(name: 'WU LYF') }
    let(:album) { Album.new(name: 'Tell Fire To The Mountain', artist: artist) }
    let(:spotify_album_tracks) do
      [
        double('SpotifyTrack', popularity: 1),
        top_track,
        double('SpotifyTrack', popularity: 50)
      ]
    end
    let(:spotify_album) do
      double('SpotifyAlbum', name: 'Tell Fire To the Mountain',
                             tracks: spotify_album_tracks)
    end
    let(:spotify_artist) { double('SpotifyArtist', name: artist.name, albums: [spotify_album]) }
    let(:spotify_client) { RSpotify }

    before do
      RSpotify::Artist.tap do |rc|
        allow(rc)
          .to receive(:search)
          .with('WU LYF')
          .and_return([spotify_artist])
      end

      RSpotify::Album.tap do |rc|
        allow(rc)
          .to receive(:search)
          .with('Tell Fire To The Mountain')
          .and_return([])
      end
    end

    subject do
      described_class.new(album: album, spotify_client: spotify_client)
    end

    it 'returns top album track' do
      expect(subject.top).to eq top_track
    end

    context 'with artist not found' do
      let(:spotify_artist) { nil }

      it 'returns nil' do
        expect(subject.top).to be_nil
      end
    end

    context 'with album not found' do
      let(:spotify_album) { double('SpotifyAlbum', name: 'Garbage') }

      it 'returns nil' do
        expect(subject.top).to be_nil
      end
    end

    context 'with album not found but under different artist entry' do
      let(:spotify_album) { double('SpotifyAlbum', name: 'Garbage') }
      let(:spotify_album2) do
        double('SpotifyAlbum', name: 'Tell Fire To the Mountain',
                               artists: [spotify_artist],
                               tracks: spotify_album_tracks)
      end

      before do
        RSpotify::Album.tap do |rc|
          allow(rc)
            .to receive(:search)
            .with('Tell Fire To The Mountain')
            .and_return([spotify_album2])
        end
      end

      it 'returns top album track' do
        expect(subject.top).to eq top_track
      end
    end
  end
end
