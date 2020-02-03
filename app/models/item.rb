class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.find_by_date(param_hash)
    order(:id).find_by(param_hash)
  end

  def self.find_all(param_hash)
    where(param_hash)
  end

  def self.find_by_merchant(param_hash)
    order(:id).where(param_hash)
  end
end
