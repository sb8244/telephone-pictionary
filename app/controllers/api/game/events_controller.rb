class Api::Game::EventsController < Api::BaseController
  before_filter :validate_game!

  def index
    render json: game.events
  end

  def show
    render json: event
  end

  def create
    render json: Event::Create.new(params, game.events).execute!
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end

  def event
    @event ||= game.events.find(params[:id])
  end
end
