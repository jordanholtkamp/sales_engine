class Api::V1::Invoices::MerchantsController < ApplicationController
  def show
    invoice_merchant = Invoice.find(params[:invoice_id]).merchant
    render json: MerchantSerializer.new(invoice_merchant)
  end
end