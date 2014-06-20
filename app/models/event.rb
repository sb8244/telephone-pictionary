class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def type
    position.even? ? :text : :drawing
  end
end
