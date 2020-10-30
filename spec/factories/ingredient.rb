FactoryBot.define do
  factory :ingredient do
    name { 'ジン' }
    type_name { 'アルコール' }
    alcohol { '40' }
  end
  factory :ingredient2 do
    name { 'ホワイト・ラム' }
    type_name { 'アルコール' }
    alcohol { '40' }
  end
  factory :ingredient3 do
    name { 'ホワイト・キュラソー' }
    type_name { 'アルコール' }
    alcohol { '40' }
  end
  factory :ingredient4 do
    name { 'レモン・ジュース' }
    type_name { '副材料' }
    alcohol { '0' }
  end
end