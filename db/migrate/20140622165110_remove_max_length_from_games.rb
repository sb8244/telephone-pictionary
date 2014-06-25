class RemoveMaxLengthFromGames < ActiveRecord::Migration
  def up
    remove_column :games, :max_length
  end

  def down
    add_column :games, :max_length, :integer, null: false, default: 9
  end
end
