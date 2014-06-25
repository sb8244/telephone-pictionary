Game::LastEvent = Struct.new(:game, :user) do

  def event
    if game.events.count > 0 # There is no last event without events
      game.events.where(step: previous_step, user: neighbor).first
    end
  end

  private

  def previous_step
    @previous_step ||= game.current_step - 1
  end

  # Always take the left neighbor because looking from previous to future
  def neighbor
    neighbor_index = round_table.find_index(user) - 1
    round_table[neighbor_index]
  end

  def round_table
    game.users.order(id: :asc)
  end

end
