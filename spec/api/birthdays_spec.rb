require 'rails_helper'

RSpec.describe "Birthdays API" do

  describe "GET /birthdays" do
    it 'sends a list of birthdays for the week' do
      2.times { create(:person) }

      get '/v1/birthdays'

      expect(response).to be_success
      expect(response_json.length).to eq(2)
    end

    it "sends name, day of week for birthday, and age" do
      Timecop.freeze("2014-4-30") do
        person = create(:person, name:          "Jerry Seinfeld",
                                 date_of_birth: Date.parse("1954-4-29") )
        get '/v1/birthdays'
        expect(response_json).to eq [birthday_json(person)]
      end
    end
  end

end