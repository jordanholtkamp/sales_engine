class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  def show
    fav_merchy = Merchant.favorite(params[:customer_id].to_i).first
    render json: MerchantSerializer.new(fav_merchy)
  end
end