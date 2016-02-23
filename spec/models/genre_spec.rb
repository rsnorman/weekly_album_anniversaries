require 'rails_helper'

RSpec.describe Genre do
  it { should validate_presence_of(:name) }

  it "generates a token" do
    genre = create(:genre)
    expect(genre.uuid).to_not be_nil
  end
end
