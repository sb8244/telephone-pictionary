require 'rails_helper'

RSpec.describe Event::Create, :type => :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:room) { user.rooms.create!(title: "Room", is_public: true) }
  let!(:game) { room.games.create!(room: room) }

  subject { Event::Create.new(wrapped, game.events) }

  let(:params) { { event: { step: 0, data: "Cat munching on asparagus", sequence: 0} } }
  let(:wrapped) { ActionController::Parameters.new(params) }

  it "creates an event" do
    expect{
      subject.execute!
    }.to change{ Event.count }.by(1)
    expect(Event.last.data).to eq("Cat munching on asparagus")
  end
end
