class AddColmnToEvents < ActiveRecord::Migration[5.0]
  def change
  	remove_column :events, :guest_id, :integer
    add_column :events, :start_at, :datetime
    add_column :events, :end_at, :datetime
    add_column :events, :guest_ids, :integer, array: true, default: []
  end
end
