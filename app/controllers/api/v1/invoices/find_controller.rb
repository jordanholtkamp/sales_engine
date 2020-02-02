class Api::V1::Invoices::FindController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find_by(invoice_params))
  end

  def index
    if params['customer_id']
      render json: InvoiceSerializer.new(Invoice.find_by_customer(invoice_params))
    else
      render json: InvoiceSerializer.new(Invoice.find_all(invoice_params))
    end
  end

  private
  
  def invoice_params
    params.permit(:id, :status, :merchant_id, :customer_id, :created_at, :updated_at)
  end
end