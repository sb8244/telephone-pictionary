require 'rails_helper'

RSpec.describe Game::Create, :type => :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:room) { Room.create(title: "Room", is_public: true) }

  subject { Game::Create.new(params, room.games, user: user) }

  let(:params) {
    ActionController::Parameters.new({
      game: {
        user_ids: [user2.id]
      }
    })
  }

  context "without user ids" do
    before { params[:game][:user_ids] = nil }
    it "doesn't create a game without user ids" do
      expect{
        subject.execute!
      }.to raise_error Api::Error
    end
  end

  it "creates a new game" do
    expect{
      subject.execute!
    }.to change{ room.games.count }.by(1)
  end

  it "adds players to the game" do
    subject.execute!
    expect(room.games.last.users).to include(user)
    expect(room.games.last.users).to include(user2)
  end
end
