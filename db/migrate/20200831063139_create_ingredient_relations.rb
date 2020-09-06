class CreateIngredientRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredient_relations do |t|
      t.references :cocktail, foreign_key: true ,null: false
      t.references :ingredient, foreign_key: true ,null: false
      t.string :amount
      t.integer :unit, null: false

      t.timestamps
    end
  end
end
