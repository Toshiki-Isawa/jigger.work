class AddColumnEntries < ActiveRecord::Migration[5.2]
  def up
    add_column :entries, :last_entry_at, :datetime
  end
end
