require 'rails_helper'

RSpec.describe Api::RoomsController, :type => :controller do
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in(user)
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET index" do
    context "with public rooms" do
      let(:public_room_count) { 3 }
      before { public_room_count.times {|i| Room.create(title: "Room #{i}", is_public: true) } }

      it "shows rooms" do
        get :index
        expect(response_json.count).to eq(public_room_count)
      end
    end

    context "with rooms I belong to" do
      before { user.rooms.create!(title: "Room", is_public: false) }

      it "shows private rooms" do
        get :index
        expect(response_json.count).to eq(1)
      end
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new room" do
        expect{
          post :create, room: { title: "Room", is_public: true }
        }.to change{ Room.count }.by(1)

        expect(response).to be_success
      end

      it "associates the user properly" do
        expect{
          post :create, room: { title: "Room", is_public: true }
        }.to change{ user.reload.rooms.count }.to(1)
      end
    end

    context "with invalid params" do
      it "does not create a new room" do
        expect{
          post :create, room: { is_public: true }
        }.not_to change{ Room.count }

        expect(response).not_to be_success
      end
    end
  end

  describe "GET show" do
    context "with rooms I can view" do
      let(:public_room) { Room.create(title: "Room", is_public: true) }

      it "shows the room" do
        get :show, id: public_room.id
        expect(response_json["id"]).to eq(public_room.id)
      end
    end

    context "with rooms I can not view" do
      let(:private_room) { Room.create(title: "Room", is_public: false) }

      it "does not show the room" do
        get :show, id: private_room.id
        expect(response.status).to eq(404)
      end
    end
  end

  describe "DELETE destroy" do
    context "with rooms I can view" do
      let!(:public_room) { Room.create(title: "Room", is_public: true) }

      it "destroys the room" do
        expect{
          delete :destroy, id: public_room.id
        }.to change{ Room.count }.by(-1)
        expect(response_json["id"]).to eq(public_room.id)
      end
    end
  end

  describe 'POST join' do
    context "with rooms I can view" do
      let(:public_room) { Room.create(title: "Room", is_public: true) }

      it "shows the room" do
        post :join, id: public_room.id
        expect(response_json["id"]).to eq(public_room.id)
      end

      it "joins the room" do
        expect {
          post :join, id: public_room.id
        }.to change{ user.reload.rooms.include?(public_room) }.to(true)
      end
    end
  end
end
