require 'rails_helper'

RSpec.describe Game, :type => :model do

  let(:user) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  subject { Game.create! }

  it "has the right game length" do
    subject.users << user
    expect(subject.game_length).to eq(1)
    subject.users << user2
    expect(subject.game_length).to eq(2)
  end

  describe "current_step" do
    before { subject.users << user && subject.users << user2 }

    context "with no events" do
      it "has the correct step" do
        expect(subject.current_step).to eq(0)
      end
    end

    context "with no events in the latest step" do
      before do
        subject.events.create!(step: 0, user: user, data: "Test", sequence: 0)
        subject.events.create!(step: 0, user: user2, data: "Test", sequence: 0)
      end

      it "has the correct step" do
        expect(subject.current_step).to eq(1)
      end
    end

    context "with events in the latest step" do
      before do
        subject.events.create!(step: 0, user: user, data: "Test", sequence: 0)
        subject.events.create!(step: 0, user: user2, data: "Test", sequence: 0)
        subject.events.create!(step: 1, user: user, data: "Test", sequence: 0)
      end

      it "has the correct step" do
        expect(subject.current_step).to eq(1)
      end
    end

    context "with a done game" do
      before do
        subject.events.create!(step: 0, user: user, data: "Test", sequence: 0)
        subject.events.create!(step: 0, user: user2, data: "Test", sequence: 0)
        subject.events.create!(step: 1, user: user, data: "Test", sequence: 0)
        subject.events.create!(step: 1, user: user2, data: "Test", sequence: 0)
      end

      it "has the correct step" do
        expect(subject.current_step).to eq(subject.game_length)
      end
    end
  end

  describe "waiting_on" do
    before { subject.users << user && subject.users << user2 }

    context "with no events in the latest step" do
      before do
        subject.events.create!(step: 0, user: user, data: "Test", sequence: 0)
        subject.events.create!(step: 0, user: user2, data: "Test", sequence: 0)
      end

      it "has the right list" do
        expect(subject.waiting_on).to include(user)
        expect(subject.waiting_on).to include(user2)
      end
    end

    context "with events in the latest step" do
      before do
        subject.events.create!(step: 0, user: user, data: "Test", sequence: 0)
        subject.events.create!(step: 0, user: user2, data: "Test", sequence: 0)
        subject.events.create!(step: 1, user: user, data: "Test", sequence: 0)
      end

      it "has the right list" do
        expect(subject.waiting_on).not_to include(user)
        expect(subject.waiting_on).to include(user2)
      end

      context "with a finished game" do
        before do
          subject.events.create!(step: 1, user: user2, data: "Test", sequence: 0)
          subject.events.create!(step: 2, user: user, data: "Test", sequence: 0)
          subject.events.create!(step: 2, user: user2, data: "Test", sequence: 0)
        end

        it "is empty" do
          expect(subject.waiting_on).to eq([])
        end
      end
    end
  end
end
