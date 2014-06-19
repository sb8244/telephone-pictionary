class Event < ActiveRecord::Base
  has_one :drawing
  belongs_to :user
  belongs_to :game

  def type
    position.even? ? :text : :drawing
  end
end
