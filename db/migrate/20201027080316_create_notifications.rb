class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id
      t.integer :visited_id
      t.integer :cocktail_id
      t.integer :rate_id
      t.string :chat_room_id
      t.string :direct_message_id
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
