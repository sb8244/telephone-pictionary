class AddUniqueIndexToGamesUsers < ActiveRecord::Migration
  def change
    add_index :games_users, [:user_id, :game_id], unique: true
  end
end
