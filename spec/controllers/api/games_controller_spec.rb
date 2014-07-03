require 'rails_helper'

RSpec.describe Api::GamesController, :type => :controller do
let!(:user) { FactoryGirl.create(:user) }
  let(:room) { Room.create(title: "Room", is_public: true) }
  let!(:game) { room.games.create! }

  before(:each) do
    sign_in(user)
    request.env["HTTP_ACCEPT"] = 'application/json'
    game.users << user
  end

  describe "GET show" do
    it "has the right game" do
      get :show, id: game.id
      expect(response_json["id"]).to eq(game.id)
    end

    it "doesn't show games I don't belong to" do
      get :show, id: room.games.create!.id
      expect(response_json["id"]).to eq(nil)
    end
  end

  describe "DELETE destroy" do
    it "removes a game" do
      expect{
        delete :destroy, id: game.id
      }.to change{ room.games.count }.by(-1)
    end
  end

  describe "POST start" do
    pending "The specs"
  end
end
