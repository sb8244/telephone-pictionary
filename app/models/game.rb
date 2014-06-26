class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :events
  belongs_to :room

  def current_step
    step = Game::CurrentStep.new(self).step
  end

  def round_data(user)
    Game::LastEvent.new(self, user).event.try!(:data)
  end

  def finished?
    current_step > 1 && current_step >= game_length
  end

  def current_step_type
    Event.type(current_step)
  end

  def game_length
    users.count
  end

  def waiting_on
    users_completed = events.where(step: current_step).includes(:user).map{ |e| e.user }
    users - users_completed
  end
end
