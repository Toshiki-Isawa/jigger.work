class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :cocktail
end
