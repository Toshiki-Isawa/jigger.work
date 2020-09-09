class CreateSimilars < ActiveRecord::Migration[5.2]
  def change
    create_table :similars do |t|
      t.integer :cocktail1
      t.integer :cocktail2
      t.float :value

      t.timestamps
    end
  end
end
