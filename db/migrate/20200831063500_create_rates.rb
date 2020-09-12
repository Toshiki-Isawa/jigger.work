class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.string :end_user_id, null: false
      t.string :cocktail_id, null: false
      t.float :rate, null: false, default: 0
      t.string :comment

      t.timestamps
    end
  end
end
