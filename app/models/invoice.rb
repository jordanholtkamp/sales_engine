class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  # validates_presence_of :status

  enum status: %w(shipped)

  def self.find_all(param_hash)
    where(param_hash)
  end

  def self.find_by_customer(param_hash)
    order(:id).where(param_hash)
  end
end
