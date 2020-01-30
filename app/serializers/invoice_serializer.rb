class InvoiceSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items

  attributes :id, :status, :customer_id, :merchant_id
end