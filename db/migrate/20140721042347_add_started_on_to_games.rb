class AddStartedOnToGames < ActiveRecord::Migration
  def change
    add_column :games, :started_on, :datetime
  end
end
