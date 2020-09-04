class Cocktail < ApplicationRecord
  enum base_name: {
    ノンアルコール: 0,
    ジン: 1,
    ウォッカ: 2,
    テキーラ: 3,
    ラム: 4,
    ウィスキー: 5,
    ブランデー: 6,
    リキュール: 7,
    ワイン: 8,
    ビール: 9,
    日本酒: 10,
  }
  enum technique_name: {
    ビルド: 1,
    ステア: 2,
    シェイク: 3,
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

  has_many :ingredients, through: :ingredient_relations
  has_many :ingredient_relations, dependent: :destroy
  accepts_nested_attributes_for :ingredient_relations, allow_destroy:true
end
