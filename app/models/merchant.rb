class Merchant < ApplicationRecord
  # validates_presence_of :name
  has_many :invoices
  has_many :items

  def self.find_all(param_hash)
    where(param_hash)
  end
end
