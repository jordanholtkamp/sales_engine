class Api::V1::MerchantsController < ApplicationController
  def index
    require 'pry'; binding.pry
    render json: Merchant.all
  end
end