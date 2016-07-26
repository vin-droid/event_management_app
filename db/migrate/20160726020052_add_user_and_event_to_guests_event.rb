class AddUserAndEventToGuestsEvent < ActiveRecord::Migration[5.0]
  def change
    add_reference :guests_events, :event, foreign_key: true
    add_reference :guests_events, :user, foreign_key: true
  end
end
