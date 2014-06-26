require 'rails_helper'

RSpec.describe GameInviter do
  let(:room) { Room.create(title: "Room", is_public: true) }
  let!(:game) { room.games.create! }

  context "with an already existing user" do
    let!(:user) { FactoryGirl.create(:user) }

    it "adds the user to the game" do
      expect {
        GameInviter.new(game, user.email).invite
      }.to change{ game.users.count }.by(1)

      expect(game.users).to include(user)
    end
  end

end
