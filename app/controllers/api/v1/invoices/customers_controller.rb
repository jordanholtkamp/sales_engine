class Api::V1::Invoices::CustomersController < ApplicationController
  def show
    invoice_customer = Invoice.find(params[:invoice_id]).customer
    render json: CustomerSerializer.new(invoice_customer)
  end
end