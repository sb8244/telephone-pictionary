class Api::Game::EventsController < Api::BaseController
  before_filter :validate_game!

  def index
    render json: game.events
  end

  def show
    render json: event
  end

  def create
    event = game.events.create!(event_params)
    trigger_pusher
    render json: event
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end

  def event
    @event ||= game.events.find(params[:id])
  end

  def trigger_pusher
    game.users_except(current_user).each do |user|
      Pusher.trigger("user-#{user.id}", "game.load", game.id)
    end
  end

  def event_params
    params.require(:event).permit(:step, :data, :sequence).merge(user_id: current_user.id)
  end
end
