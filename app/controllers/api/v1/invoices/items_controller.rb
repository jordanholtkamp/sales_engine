class Api::V1::Invoices::ItemsController < ApplicationController
  def index
    invoice_items = Invoice.find(params[:invoice_id]).items.uniq
    render json: ItemSerializer.new(invoice_items)
  end
end