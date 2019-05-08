# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnniversariesController do
  describe '#index' do
    let(:genre) { create(:genre) }
    let(:album) { create(:album, genre: genre, name: 'Kid A') }

    before do
      expect(WeeklyAnniversaryQuery)
        .to receive(:new)
        .with(genre.albums, anything)
        .and_call_original
      expect_any_instance_of(WeeklyAnniversaryQuery)
        .to receive(:find_all).and_return([album])

      get :index
    end

    it 'should return successful response' do
      expect(response).to be_ok
    end

    it 'should return albums with Anniversaries' do
      expect(response_json['albums'].first['name']).to eq 'Kid A'
    end
  end
end
