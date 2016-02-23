require 'rails_helper'

RSpec.describe "Anniversaries API" do
  def get_anniversaries(genre)
    get '/v1/anniversaries', {}
  end

  describe "GET /anniversaries" do
    let(:genre) { create :genre }
    it 'sends a list of anniversaries for the week' do
      2.times { create(:album, genre: genre) }

      get_anniversaries(genre)

      expect(response).to be_success
      expect(response_json['albums'].length).to eq(2)
    end

    it "sends name, day of week for Anniversary, and age" do
      Timecop.freeze("2014-4-30") do
        album = create(:album, genre:        genre,
                                 name:         "Kid A",
                                 release_date: Date.parse("1954-4-29") )
        get_anniversaries(genre)

        expect(response_json['albums']).to eq [anniversary_json(album)]
      end
    end

    context "with anniversaries before this week" do
      before { create(:album, genre:        genre,
                               release_date: Date.current.beginning_of_week - 30.years - 1.day) }

      it "should return no anniversaries" do
        get_anniversaries(genre)

        expect(response).to be_success
        expect(response_json['albums'].length).to eq 0
      end
    end

    context "with anniversaries after this week" do
      before { create(:album, genre:        genre,
                               release_date: Date.current.end_of_week - 30.years + 1.day) }

      it "should return no anniversaries" do
        get_anniversaries(genre)

        expect(response).to be_success
        expect(response_json['albums'].length).to eq 0
      end
    end
  end

end
