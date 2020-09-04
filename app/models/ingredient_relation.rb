class IngredientRelation < ApplicationRecord
  enum unit: {
    ml: 1,
    tsp: 2,
    dash: 3,
    枚: 4,
    個: 5,
    適量: 6,
    FullUp: 7,
  }

  belongs_to :cocktail
  belongs_to :ingredient
end
