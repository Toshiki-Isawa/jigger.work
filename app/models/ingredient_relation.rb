class IngredientRelation < ApplicationRecord
  validates :ingredient_id, presence: true

  enum unit: {
    ml: 1,
    'tsp.': 2,
    dash: 3,
    枚: 4,
    個: 5,
    適量: 6,
    FullUP: 7,
    glass: 8,
  }

  belongs_to :cocktail
  belongs_to :ingredient
end
