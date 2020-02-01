class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  # validates_presence_of :name
  # validates_presence_of :description
  # validates_presence_of :unit_price=

  def self.find_by_date(param_hash)
    Item.order(:id).find_by(param_hash)
  end
end
