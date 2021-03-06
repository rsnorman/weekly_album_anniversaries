# frozen_string_literal: true

require 'spec_helper'
require './lib/services/account_growth/recent_twitter_interactors'

RSpec.describe AccountGrowth::RecentTwitterInteractors do
  describe '#screen_names' do
    before do
      allow(OpenURI)
        .to receive(:open_uri)
        .with(described_class::FAVSTAR_RECENT_URI)
        .and_return(File.read('./spec/support/fixtures/recent_favorites.html'))
    end

    it 'returns recent screen names that interacted with system account' do
      expect(subject.screen_names).to eq %w[
        WistfulIndie
        RogerGuelph
        davidjonesusa
        theforteband
        FeliceLaZae
        LocusPromo
        IndieMusicBlas
        WeirdoMusic4evr
        quinnythep000
        thabone22
        weirdoslam
        chrisdrunkpoets
        demegalansolana
        sodiumlitskies
        andrewrwales
        ellenallien
        SgtCoumarin
        yoozy_cutie
        NocturnMp3
        rainbowfur2008
        chariotsmusic
        FaithandHarry
      ]
    end
  end
end
