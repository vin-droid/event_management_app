class AddUserToFriendships < ActiveRecord::Migration[5.0]
  def change
  	remove_column :friendships, :user_id, :integer
    add_reference :friendships, :user, foreign_key: true
  end
end
