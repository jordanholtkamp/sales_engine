class Api::V1::Customers::InvoicesController < ApplicationController
  def index
    customer_invoices = Customer.find(params[:customer_id]).invoices
    render json: InvoiceSerializer.new(customer_invoices)
  end
end