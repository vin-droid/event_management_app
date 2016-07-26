class RemoveColumnGuestIdsFromEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :guest_ids, :integer
  end
end
