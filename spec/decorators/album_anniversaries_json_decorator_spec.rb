# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlbumAnniversariesJsonDecorator do
  describe '#to_api_json' do
    let(:today)    { Date.parse('2015-11-20') }
    let(:release)  { Date.parse('1984-11-22') }
    around         { |ex| Timecop.freeze(today) { ex.run } }
    let(:album)    do
      create(:album, name: 'Kid A',
                     release_date: release)
    end
    subject do
      JSON.parse(AlbumAnniversariesJsonDecorator.new([album]).to_api_json)['albums'].first
    end

    it 'should return name' do
      expect(subject['name']).to eq 'Kid A'
    end

    it 'should return UUID' do
      expect(subject['uuid']).to eq album.uuid
    end

    it 'should return release_date' do
      expect(subject['release_date']).to eq release.in_time_zone.to_i
    end

    it 'should return release_date_string' do
      expect(subject['release_date_string']).to eq release.to_s
    end

    it 'should return age' do
      expect(subject['age']).to eq 31
    end

    it 'should return anniversary' do
      expect(subject['anniversary']).to eq Date.parse('2015-11-22').in_time_zone.to_i
    end

    it 'should return anniversary_string' do
      expect(subject['anniversary_string']).to eq Date.parse('2015-11-22').to_s
    end

    it 'should return day_of_week' do
      expect(subject['day_of_week']).to eq 'Sunday'
    end

    it 'should return thumbnail_url' do
      expect(subject['thumbnail_url']).to eq 'thumbnail.jpg'
    end

    it 'should return link' do
      expect(subject['link']).to eq "/albums/#{album.slug}"
    end
  end
end
