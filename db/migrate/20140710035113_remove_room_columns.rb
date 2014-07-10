class RemoveRoomColumns < ActiveRecord::Migration
  def up
    remove_column :games, :room_id
    drop_table :rooms_users
  end

  def down
    raise "Can't be downgraded"
  end
end
