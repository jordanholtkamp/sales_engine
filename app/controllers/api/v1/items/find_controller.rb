class Api::V1::Items::FindController < ApplicationController
  def show
    if params["unit_price"]
      float = item_params['unit_price'].to_f*100
      render json: ItemSerializer.new(Item.find_by(unit_price: float.round()))
    elsif params['created_at'] || params['updated_at']
      render json: ItemSerializer.new(Item.find_by_date(item_params))
    else
      render json: ItemSerializer.new(Item.find_by(item_params))
    end
  end

  private
  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end