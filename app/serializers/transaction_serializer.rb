class TransactionSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :invoice

  attributes :id, :invoice_id, :result, :credit_card_number
end