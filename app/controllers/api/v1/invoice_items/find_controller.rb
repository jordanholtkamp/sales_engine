class Api::V1::InvoiceItems::FindController < ApplicationController
  def show
    if params['unit_price']
      float = invoice_item_params['unit_price'].to_f*100
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(unit_price: float.round()))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
    end
  end

  def index
    if params['unit_price']
      float = invoice_item_params['unit_price'].to_f*100
      render json: InvoiceItemSerializer.new(InvoiceItem.find_all(unit_price: float.round()))
    elsif params['invoice_id']
      render json: InvoiceItemSerializer.new(InvoiceItem.find_all_by_invoice(invoice_item_params))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find_all(invoice_item_params))
    end
  end

  private
  def invoice_item_params
    params.permit(:id, :invoice_id, :item_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end