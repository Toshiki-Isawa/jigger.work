class CreateCocktails < ActiveRecord::Migration[5.2]
  def change
    create_table :cocktails do |t|
      t.references :end_user, foreign_key: true, null: false
      t.string :name, null: false
      t.integer :base_name
      t.integer :technique_name, null: false
      t.integer :taste_name, null: false
      t.integer :style_name, null: false
      t.integer :alcohol, null: false
      t.integer :tpo_name, null: false
      t.text :cocktail_desc
      t.text :recipe_desc, null: false
      t.string :image_id

      t.timestamps
    end

    add_index :cocktails, :name,          unique: true
  end
end
