class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :position, null: false
      t.integer :user_id, null: false
      t.integer :game_id, null: false

      t.timestamps
    end
  end
end
