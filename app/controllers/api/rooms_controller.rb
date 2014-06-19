class Api::RoomsController < Api::BaseController

  before_filter :validate_room!, only: [:show, :destroy]

  def index
    render json: rooms
  end

  def show
    render json: room
  end

  def create
    render json: current_user.rooms.create!(room_params)
  end

  def destroy
    render json: room.destroy
  end

  def join
    current_user.rooms << room

    render json: room
  end

  private

  def room_params
    params.require(:room).permit(:title, :is_public)
  end

  def rooms
    current_user.accessible_rooms
  end

  def room
    Room.find(params[:id])
  end
end
