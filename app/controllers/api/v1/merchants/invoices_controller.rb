class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    merchant_invoices = Merchant.find(params[:merchant_id]).invoices
    render json: InvoiceSerializer.new(merchant_invoices)
  end
end
