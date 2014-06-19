class CreateRoomsUsers < ActiveRecord::Migration
  def change
    create_table :rooms_users do |t|
      t.integer :user_id, null: false
      t.integer :room_id, null: false
    end
  end
end
