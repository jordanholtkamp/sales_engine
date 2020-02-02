class Merchant < ApplicationRecord
  # validates_presence_of :name
  has_many :invoices
  has_many :items

  def self.find_all(param_hash)
    where(param_hash)
  end

  def self.find_top_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions]).
    select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue').
    group(:id).
    merge(Transaction.successful).
    order('revenue desc').
    limit(quantity)
  end

  def self.favorite(customer_id)
    joins(invoices: :transactions).
    select('merchants.*, count(transactions.id) as total_successful_transactions').
    merge(Transaction.successful).
    where("invoices.customer_id = #{customer_id}").
    group(:id).
    order('total_successful_transactions desc').
    limit(1)
  end
end
