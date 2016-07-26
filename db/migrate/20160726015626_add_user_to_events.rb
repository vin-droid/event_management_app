class AddUserToEvents < ActiveRecord::Migration[5.0]
  def change
  	remove_column :events, :host_name, :string
    add_reference :events, :user, foreign_key: true
  end
end
