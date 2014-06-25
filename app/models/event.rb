class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def self.type(step)
    step.even? ? :text : :drawing
  end

  def type
    self.class.type(step)
  end
end
