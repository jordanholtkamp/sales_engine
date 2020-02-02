class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    fav_custy = Customer.favorite(params[:merchant_id].to_i).first
    render json: CustomerSerializer.new(fav_custy)
  end
end