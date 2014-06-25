class RemoveCurrentPositionFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :current_position
  end

  def down
    add_column :games, :current_position, :integer, default: 0, null: false
  end
end
