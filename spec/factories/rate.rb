FactoryBot.define do
  factory :rate do
    rate { Faker::Number.within(range: 1.0..5.0) }
    comment { Faker::Lorem.characters(number:20) }
    end_user
    cocktail
  end
end