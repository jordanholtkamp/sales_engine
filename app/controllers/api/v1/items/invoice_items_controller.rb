class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    item_invoice_items = Item.find(params[:item_id]).invoice_items
    render json: InvoiceItemSerializer.new(item_invoice_items)
  end
end