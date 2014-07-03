require 'rails_helper'

RSpec.describe Game::History, :type => :model do
  let!(:u1) { FactoryGirl.create(:user) }
  let!(:u2) { FactoryGirl.create(:user) }
  let!(:u3) { FactoryGirl.create(:user) }
  let!(:room) { Room.create(title: "Room", is_public: true) }
  let(:game) { room.games.create!(users: [u1, u2, u3]) }

  # lots of setup to fill up the game
  let!(:e1) { game.events.create(user: u1, step: 0, data: "a", sequence: 0) }
  let!(:e2) { game.events.create(user: u2, step: 0, data: "b", sequence: 1) }
  let!(:e3) { game.events.create(user: u3, step: 0, data: "c", sequence: 2) }

  let!(:e4) { game.events.create(user: u1, step: 1, data: "d", sequence: 2) }
  let!(:e5) { game.events.create(user: u2, step: 1, data: "e", sequence: 0) }
  let!(:e6) { game.events.create(user: u3, step: 1, data: "f", sequence: 1) }

  let!(:e7) { game.events.create(user: u1, step: 2, data: "g", sequence: 1) }
  let!(:e8) { game.events.create(user: u2, step: 2, data: "h", sequence: 2) }
  let!(:e9) { game.events.create(user: u3, step: 2, data: "i", sequence: 0) }

  let!(:e10) { game.events.create(user: u1, step: 3, data: "j", sequence: 0) }
  let!(:e11) { game.events.create(user: u2, step: 3, data: "k", sequence: 1) }
  let!(:e12) { game.events.create(user: u3, step: 3, data: "l", sequence: 2) }

  subject { Game::History.new(game).history}

  it "has the right chain starting at e1" do
    expect(subject[0]).to eq([e1, e5, e9, e10])
  end

  it "has the right chain starting at e2" do
    expect(subject[1]).to eq([e2, e6, e7, e11])
  end

  it "has the right chain starting at e3" do
    expect(subject[2]).to eq([e3, e4, e8, e12])
  end

end
