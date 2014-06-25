class RenamePositionOnEvents < ActiveRecord::Migration
  def change
    rename_column :events, :position, :step
  end
end
