class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :invoice
  belongs_to :item

  attributes :id, :invoice_id, :item_id, :quantity

  attribute :unit_price do |invoice_item|
    invoice_item.unit_price / 100
  end
end