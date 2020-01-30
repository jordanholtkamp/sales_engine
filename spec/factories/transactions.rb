FactoryBot.define do
  factory :transaction do
    credit_card_number {"1234567891012345"}
    credit_card_expiration_date { "2020-01-27 17:03:06" }
  end
end
