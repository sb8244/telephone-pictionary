class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :rooms
  has_and_belongs_to_many :games

  has_many :drawings
  has_many :events

  # Accessible rooms are either public or joined
  def accessible_rooms
    Room.all_public | rooms
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
