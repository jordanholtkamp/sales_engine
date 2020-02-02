class Api::V1::Items::MerchantsController < ApplicationController
  def show
    item_merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.new(item_merchant)
  end
end