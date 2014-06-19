class Drawing < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  belongs_to :room
end
