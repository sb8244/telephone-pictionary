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
    game.users.each do |user|
      game.events.create!(step: 0, user: user, data: random_text)
    end
    render json: game
  end

  private

  def game
    Game.find(params[:id])
  end

  def random_text
    list = ["apple", "boy", "chair", "grill", "building", "Atlanta"]
    list.sample
  end
end
