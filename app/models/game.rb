class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :events
  belongs_to :room

  def current_step
    step = Game::CurrentStep.new(self).step
  end

  # The game starts with step 0 (auto generated) and goes round robin
  # back and forth. So a 2 player game ends when step 2 is complete and
  # step 3 is current
  def finished?
    current_step > 1 && current_step >= game_length + 1
  end

  def current_step_type
    Event.type(current_step)
  end

  def game_length
    users.count
  end

  def waiting_on
    return [] if finished?
    users_completed = events.where(step: current_step).joins(:user).map{ |e| e.user }
    users - users_completed
  end

  ### Last Event for User methods ###

  def sequence_id(user)
    Game::LastEvent.new(self, user).event.try!(:sequence)
  end

  def round_data(user)
    Game::LastEvent.new(self, user).event.try!(:data)
  end
end
