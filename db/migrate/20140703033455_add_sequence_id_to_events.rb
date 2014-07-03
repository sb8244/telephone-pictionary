class AddSequenceIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :sequence, :integer
  end
end
