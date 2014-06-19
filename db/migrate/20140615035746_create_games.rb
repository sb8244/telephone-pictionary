class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :max_length, default: 9
      t.integer :current_position, default: 0
      t.integer :room_id, null: false

      t.timestamps
    end
  end
end
