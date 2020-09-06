class Cocktail < ApplicationRecord
  enum technique_name: {
    ビルド: 1,
    ステア: 2,
    シェイク: 3,
    ブレンド: 4,
  }
  enum taste_name: {
    甘口: 1,
    中甘口: 2,
    中口: 3,
    中辛口: 4,
    辛口: 5,
  }
  enum style_name: {
    ショート: 1,
    ロング: 2,
  }
  enum tpo_name: {
    食前: 1,
    食後: 2,
    オール: 3,
  }

  belongs_to :end_user
  attachment :image

  has_many :ingredient_relations, dependent: :destroy
  has_many :ingredients, through: :ingredient_relations
  accepts_nested_attributes_for :ingredient_relations, allow_destroy:true
end
