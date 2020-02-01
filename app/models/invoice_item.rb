class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  # validates_presence_of :quantity
  # validates_presence_of :unit_price

  def self.find_all(param_hash)
    where(param_hash)
  end

  def self.find_all_by_invoice(param_hash)
    order(:id).where(param_hash)
  end
end
