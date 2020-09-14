FactoryBot.define do
  factory :cocktail do
    name { Faker::Lorem.characters(number:20) }
    base_name { 'ジン' }
    technique_name { 'ステア' }
    taste_name { '辛口' }
    style_name { 'ショート' }
    alcohol { '40' }
    tpo_name { '食前' }
    cocktail_desc { Faker::Lorem.characters(number:20) }
    recipe_desc { Faker::Lorem.characters(number:20) }
    end_user
  end
end