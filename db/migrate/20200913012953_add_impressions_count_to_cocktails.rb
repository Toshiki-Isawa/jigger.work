class AddImpressionsCountToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :impressions_count, :integer, default: 0
  end
end
