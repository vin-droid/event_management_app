class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :host_name
      t.integer :guest_id

      t.timestamps
    end
  end
end
