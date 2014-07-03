class Api::GamesController < Api::BaseController
  before_filter :validate_game!

  def show
    render json: game
  end

  def destroy
    render json: game.destroy
  end

  def start
    game.update!(started: true)
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

  def game_history
    Game::History.new(game).history
  end

  def game
    Game.find(params[:id])
  end

  def random_text
    list = ["apple", "boy", "chair", "grill", "building", "Atlanta"]
    list.sample
  end
end
