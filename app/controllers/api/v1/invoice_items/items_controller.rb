class Api::V1::InvoiceItems::ItemsController < ApplicationController
  def show
    invoice_items_item = InvoiceItem.find(params[:invoice_item_id]).item
    render json: ItemSerializer.new(invoice_items_item)
  end
end