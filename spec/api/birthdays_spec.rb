require 'rails_helper'

RSpec.describe "Birthdays API" do
  def get_birthdays(client)
    get '/v1/birthdays', {}, {"HTTP_UUID" => client.uuid}
  end

  describe "GET /birthdays" do
    let(:client) { create :client }
    it 'sends a list of birthdays for the week' do
      2.times { create(:person, client: client) }

      get_birthdays(client)

      expect(response).to be_success
      expect(response_json.length).to eq(2)
    end

    it "sends name, day of week for birthday, and age" do
      Timecop.freeze("2014-4-30") do
        person = create(:person, client:        client,
                                 name:          "Jerry Seinfeld",
                                 date_of_birth: Date.parse("1954-4-29") )
        get_birthdays(client)

        expect(response_json).to eq [birthday_json(person)]
      end
    end

    context "with birthdays before this week" do
      before { create(:person, client:        client,
                               date_of_birth: Date.current.beginning_of_week - 30.years - 1.day) }

      it "should return no birthdays" do
        get_birthdays(client)

        expect(response).to be_success
        expect(response_json.length).to eq 0
      end
    end

    context "with birthdays after this week" do
      before { create(:person, client:        client,
                               date_of_birth: Date.current.end_of_week - 30.years + 1.day) }

      it "should return no birthdays" do
        get_birthdays(client)

        expect(response).to be_success
        expect(response_json.length).to eq 0
      end
    end

    context "with birthdays from a different client" do
      before { create(:person, client: create(:client)) }

      it "should return no birthdays" do
        get_birthdays(client)

        expect(response).to be_success
        expect(response_json.length).to eq 0
      end
    end
  end

end