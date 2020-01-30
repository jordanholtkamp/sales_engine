class ItemSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :merchant
  attributes :id, :name, :description, :unit_price, :merchant_id

  def unit_price
    require 'pry'; binding.pry
    unit_price / 100
  end
end