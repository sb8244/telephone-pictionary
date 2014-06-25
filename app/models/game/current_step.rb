class Game::CurrentStep
  def initialize(game)
    @game = game
  end

  def step
    position = 0 if no_events?
    position ||= check_for_partially_finished
    position ||= advance_step
    position
  end

  private

  def check_for_partially_finished
    # iterate over events grouped by position finding the first position which isn't filled
    grouped_events.each do |step, group|
      if group.count <= max_step
        return step
      end
    end
    nil
  end

  def no_events?
    @game.events.count == 0
  end

  def max_step
    @max_position ||= @game.game_length - 1
  end

  def grouped_events
    @grouped_events ||= @game.events.order(step: :asc).group_by(&:step)
  end

  def advance_step
    grouped_events.keys.last + 1
  end
end
