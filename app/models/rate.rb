class Rate < ApplicationRecord
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

  belongs_to :end_user
  belongs_to :cocktail
end
