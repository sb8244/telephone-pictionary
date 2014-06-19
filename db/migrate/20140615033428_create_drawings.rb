class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.text :data, null: false
      t.integer :user_id, null: false
      t.integer :room_id, null: false
      t.integer :event_id, null: false

      t.timestamps
    end
  end
end
