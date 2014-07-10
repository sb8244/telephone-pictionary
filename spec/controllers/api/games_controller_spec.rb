require 'rails_helper'

RSpec.describe Api::GamesController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:game) { user.games.create! }

  before(:each) do
    sign_in(user)
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET index" do
    it "shows a users games" do
      get :index
      expect(response).to be_success
      expect(response_json.count).to eq(1)
    end

    it "doesn't show games that are not the users" do
      game.users.delete(user)
      get :index
      expect(response_json.count).to eq(0)
    end
  end

  describe "GET create" do
    it "creates a game" do
      expect{
        post :create, game: { user_ids: [FactoryGirl.create(:user).id] }
      }.to change{ user.games.count }.by(1)
    end
  end

  describe "GET show" do
    it "has the right game" do
      get :show, id: game.id
      expect(response_json["id"]).to eq(game.id)
    end

    it "404s when user isn't on the game" do
      game.users.delete(user)
      get :show, id: game
      expect(response.status).to eq(404)
    end
  end

  describe "DELETE destroy" do
    it "removes a game" do
      expect{
        delete :destroy, id: game.id
      }.to change{ user.games.count }.by(-1)
    end
  end

  describe "POST start" do
    pending "The specs"
  end
end
