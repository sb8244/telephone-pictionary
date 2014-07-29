class Api::GamesController < Api::BaseController
  before_filter :validate_game!, except: [:index, :create]

  def index
    render json: games
  end

  def show
    render json: game
  end

  def create
    render json: games.create!(game_params)
  end

  def destroy
    render json: game.destroy
  end

  def start
    game.update!(started: true, started_on: Time.now)
    game.users.each_with_index do |user, i|
      game.events.create!(step: 0, user: user, data: random_text, sequence: i)
    end
    render json: game
  end

  def users
    render json: User.all - game.users
  end

  def invite
    game.users << User.find(params[:user_id]) unless game.started?
    render json: true
  end

  def history
    render json: game_history
  end

  private

  def games
    current_user.games
  end

  def game_history
    Game::History.new(game).history
  end

  def game
    Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(user_ids: [])
  end

  def random_text
    list = ["apple", "boy", "chair", "grill", "building", "Atlanta"]
    list.sample
  end
end
