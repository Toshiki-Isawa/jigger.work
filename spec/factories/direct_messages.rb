FactoryBot.define do
  factory :direct_message do
    content { "MyString" }
    end_user_id { 1 }
    room_id { 1 }
  end
end
