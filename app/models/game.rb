class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :events
  belongs_to :room

  def last_event
    events.last
  end
end
