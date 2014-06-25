require 'rails_helper'

RSpec.describe Api::Room::GamesController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let(:room) { Room.create(title: "Room", is_public: true) }
  let!(:game) { room.games.create! }

  before(:each) do
    sign_in(user)
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET index" do
    context "in a room I can not see" do
      let(:room) { Room.create(title: "Room", is_public: false) }

      it "does not show me the game" do
        get :index, room_id: room.id
        expect(response.status).to eq(404)
      end
    end

    it "does show me the game" do
      get :index, room_id: room.id
      expect(response_json.count).to eq(1)
    end
  end

  describe "POST create" do
    it "creates a game" do
      expect{
        post :create, room_id: room.id, game: { user_ids: [FactoryGirl.create(:user).id] }
      }.to change{ room.games.count }.by(1)
    end
  end
end
