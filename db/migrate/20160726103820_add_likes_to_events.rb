class AddLikesToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :likes, :integer,array: true, default: [] 
  end
end
