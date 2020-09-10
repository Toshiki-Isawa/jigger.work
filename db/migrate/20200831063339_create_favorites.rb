class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :end_user, foreign_key: true, null: false
      t.references :cocktail, foreign_key: true, null: false

      t.timestamps
    end
  end
end
