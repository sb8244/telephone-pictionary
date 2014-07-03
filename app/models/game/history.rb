# History starts with each 0 step and follows around circular until the end
class Game::History
  attr_accessor :history

  def initialize(game)
    @game = game
    @history = []
  end

  def history
    return [] unless @game.finished?
    events.order(sequence: :asc, created_at: :asc)
          .group_by(&:sequence)
          .map(&:second) # This mapped format is required to serialize the array properly
  end

  private

  def events
    @game.events.includes(:user)
  end
end
