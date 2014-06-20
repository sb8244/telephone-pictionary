class Api::RoomsController < Api::BaseController
  before_filter :validate_room!, only: [:show, :destroy]

  def index
    render json: rooms
  end

  def show
    render json: room
  end

  def create
    render json: Room::Create.new(params, current_user.rooms).execute!
  end

  def destroy
    render json: room.destroy
  end

  def join
    current_user.rooms << room

    render json: room
  end

  private

  def rooms
    current_user.accessible_rooms
  end

  def room
    Room.find(params[:id])
  end
end
