class Api::Room::GamesController < Api::BaseController
  before_filter :validate_room!

  def index
    render json: games
  end

  def show
    render json: game
  end

  def create
    render json: Game::Create.new(params, room.games).execute!
  end

  def destroy
    render json: game.destroy
  end

  private

  def room
    Room.find(params[:room_id])
  end

  def games
    room.games
  end

  def game
    games.find(params[:id])
  end
end
