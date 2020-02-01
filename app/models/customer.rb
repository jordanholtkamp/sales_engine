class Customer < ApplicationRecord
  # validates_presence_of :first_name
  # validates_presence_of :last_name

  has_many :invoices

  def self.find_all(param_hash)
    where(param_hash)
  end
end
