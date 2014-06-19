class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :title, null: false
      t.boolean :is_public, null: false, default: true

      t.timestamps
    end
  end
end
