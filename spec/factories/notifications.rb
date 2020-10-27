FactoryBot.define do
  factory :notification do
    visiter_id { 1 }
    visited_id { 1 }
    cocktail_id { 1 }
    rate_id { 1 }
    chat_room_id { "MyString" }
    direct_message_id { "MyString" }
    action { "MyString" }
    checked { false }
  end
end
