class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    limiting_quantity = request.query_parameters['quantity'].to_i
    merchant_list = Merchant.find_top_revenue(limiting_quantity)
    render json: MerchantSerializer.new(merchant_list)
  end

  def show
    find_by_date = request.query_parameters['date']
    # require 'pry'; binding.pry
  end
end