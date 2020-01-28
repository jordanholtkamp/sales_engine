FactoryBot.define do
  factory :invoice_item do
    item { nil }
    invoice { nil }
    quanity { 1 }
    unit_price { "" }
  end
end
