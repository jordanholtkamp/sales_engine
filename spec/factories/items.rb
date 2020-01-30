FactoryBot.define do
  factory :random_item , class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.between(from: 100, to: 1000) }
  end
end