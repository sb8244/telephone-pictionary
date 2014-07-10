require 'rails_helper'

RSpec.describe Game::Create, :type => :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }

  subject { Game::Create.new(params, user.games, user: user) }

  let(:params) {
    ActionController::Parameters.new({
      user_ids: [user2.id]
    })
  }

  pending "Move this into the controller"

  it "creates a new game" do
    expect{
      subject.execute!
    }.to change{ Game.count }.by(1)
  end

  it "adds players to the game" do
    subject.execute!
    expect(Game.last.users).to include(user)
    expect(Game.last.users).to include(user2)
  end
end
