require 'rails_helper'

RSpec.describe Event, :type => :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:game) { user.games.create! }

  describe "type" do
    it "is the first event" do
      event = game.events.create(step: 0, user: user, data: "1")
      expect(event.type).to eq(:text)
    end

    it "is the second event" do
      event = game.events.create(step: 1, user: user, data: "2")
      expect(event.type).to eq(:drawing)
    end
  end
end
