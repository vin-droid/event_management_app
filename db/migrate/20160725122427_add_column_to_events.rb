class AddColumnToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :image, :string
    add_column :events, :disc, :text
  end
end
