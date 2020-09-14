FactoryBot.define do
  factory :end_user do
    name { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20) }
    birth_date { '1997-01-12' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end