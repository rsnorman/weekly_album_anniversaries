require 'rails_helper'

RSpec.describe Client do

  it "generates a token" do
    client = create(:client)
    expect(client.uuid).to_not be_nil
  end

  describe "validations" do
    let(:client) { build(:client, name: nil) }

    it "should validate presence of name" do
      client.save
      expect(client).to validate_presence_of :name
    end
  end

end
