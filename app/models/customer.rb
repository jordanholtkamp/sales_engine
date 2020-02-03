class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.find_all(param_hash)
    where(param_hash)
  end

  def self.favorite(merchant_id)
    joins(invoices: :transactions).
    select('customers.*, count(transactions.id) as total_successful_transactions').
    merge(Transaction.successful).
    where("invoices.merchant_id = #{merchant_id}").
    group(:id).
    order('total_successful_transactions desc').
    limit(1)
  end
end
