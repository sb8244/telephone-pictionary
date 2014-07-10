class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:facebook]

  has_and_belongs_to_many :games

  has_many :drawings
  has_many :events

  # make current_user available everywhere
  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
