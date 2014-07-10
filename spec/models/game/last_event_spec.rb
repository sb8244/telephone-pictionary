require 'rails_helper'

RSpec.describe Game::LastEvent, :type => :model do
  let(:u1) { FactoryGirl.create(:user) }
  let(:u2) { FactoryGirl.create(:user) }
  let(:u3) { FactoryGirl.create(:user) }

  let(:game) { Game.create!(users: [u1, u2, u3]) }

  let!(:a) { game.events.create(user: u1, step: 0, data: "a", sequence: 0) }
  let!(:b) { game.events.create(user: u2, step: 0, data: "b", sequence: 0) }
  let!(:c) { game.events.create(user: u3, step: 0, data: "c", sequence: 0) }

  context "with an initial game state" do
    it "has the right step for u1" do
      expect(Game::LastEvent.new(game, u1).event).to eq(c)
    end
    it "has the right step for u2" do
      expect(Game::LastEvent.new(game, u2).event).to eq(a)
    end
    it "has the right step for u3" do
      expect(Game::LastEvent.new(game, u3).event).to eq(b)
    end
  end

  context "with the second game state" do
    let!(:d) { game.events.create(user: u1, step: 1, data: "d", sequence: 0) }
    let!(:e) { game.events.create(user: u2, step: 1, data: "e", sequence: 0) }
    let!(:f) { game.events.create(user: u3, step: 1, data: "f", sequence: 0) }

    it "has the right step for u1" do
      expect(Game::LastEvent.new(game, u1).event).to eq(f)
    end
    it "has the right step for u2" do
      expect(Game::LastEvent.new(game, u2).event).to eq(d)
    end
    it "has the right step for u3" do
      expect(Game::LastEvent.new(game, u3).event).to eq(e)
    end
  end
end
