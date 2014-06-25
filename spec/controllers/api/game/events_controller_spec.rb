require 'rails_helper'

RSpec.describe Api::Game::EventsController, :type => :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:room) { Room.create(title: "Room", is_public: true) }
  let(:game) { room.games.create!(users: [user]) }
  let!(:event) { game.events.create!(data: "Test", step: 0, user: user) }
  let!(:event2) { game.events.create!(data: "Test", step: 1, user: user) }

  before(:each) do
    sign_in(user)
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET index" do
    it "shows the events" do
      get :index, game_id: game.id
      expect(response.status).to eq(200)
      expect(response_json.count).to eq(2)
    end
  end

  describe "GET show" do
    it "shows the event" do
      get :show, game_id: game.id, id: event2.id
      expect(response.status).to eq(200)
      expect(response_json["id"]).to eq(event2.id)
    end
  end

  describe "POST create" do
    it "creates an event" do
      expect{
        post :create, game_id: game.id, event: { step: 0, data: "Test" }
      }.to change{ game.events.count }.by(1)
    end
  end
end