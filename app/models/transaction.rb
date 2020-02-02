class Transaction < ApplicationRecord
  scope :successful, -> {where(result: 0)}
  belongs_to :invoice

  enum result: %w(success failed)

  def self.find_all(param_hash)
    where(param_hash)
  end

  def self.find_all_by_invoice(param_hash)
    order(:id).where(param_hash)
  end
end
