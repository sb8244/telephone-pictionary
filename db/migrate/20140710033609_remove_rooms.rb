class RemoveRooms < ActiveRecord::Migration
  def up
    drop_table :rooms
  end

  def down
    raise "Can't be downgraded"
  end
end
