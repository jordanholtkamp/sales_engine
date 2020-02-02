class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  def index
    invoice_invoice_items = Invoice.find(params[:invoice_id]).invoice_items
    render json: InvoiceItemSerializer.new(invoice_invoice_items)
  end
end