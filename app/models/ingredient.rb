class Ingredient < ApplicationRecord
  enum type_name: {
    アルコール: 1,
    ノンアルコール: 2,
    副材料: 3,
  }
end
