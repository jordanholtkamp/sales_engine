class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  def show
    invoice_items_invoice = InvoiceItem.find(params[:invoice_item_id]).invoice
    render json: InvoiceSerializer.new(invoice_items_invoice)
  end
end