require 'rails_helper'

RSpec.describe BirthdaysController do

  describe "#index" do
    let(:person) { build(:person, name: "Cosmo Kramer") }

    before do
      expect_any_instance_of(WeeklyBirthdayQuery)
        .to receive(:find_all).and_return([person])

      get :index
    end

    it "should return successful response" do
      expect(response).to be_ok
    end

    it "should return people with birthdays" do
      expect(response_json.first["name"]).to eq "Cosmo Kramer"
    end
  end

end