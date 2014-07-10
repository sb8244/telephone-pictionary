class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:facebook]

  has_and_belongs_to_many :rooms
  has_and_belongs_to_many :games

  has_many :drawings
  has_many :events

  after_create :add_default_room

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

  private

  def add_default_room
    self.rooms.create!(title: "Private Room: #{self.email}", is_public: false)
  end
end
