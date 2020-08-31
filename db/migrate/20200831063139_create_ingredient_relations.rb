class CreateIngredientRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredient_relations do |t|
      t.integer :cocktail_id, null: false
      t.integer :ingredient_id, null: false
      t.integer :amount
      t.integer :unit, null: false

      t.timestamps
    end
  end
end
