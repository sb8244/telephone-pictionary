class Room < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :games

  scope :all_public, -> { where(is_public: true) }

  validates :title, presence: true
  validates :is_public, inclusion: [true, false]
end
