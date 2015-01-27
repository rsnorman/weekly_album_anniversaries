require 'rails_helper'

RSpec.describe "App Routes" do

  describe "birthdays" do
    it "routes /birthdays" do
      expect(get: "/v1/birthdays").to route_to(
        controller: "birthdays",
        action:     "index"
      )
    end
  end

end