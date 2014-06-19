class AddUniqueIndexToRoomsUsers < ActiveRecord::Migration
  def change
    add_index :rooms_users, [:user_id, :room_id], unique: true
  end
end
