class Api::V1::Transactions::InvoicesController < ApplicationController
  def show
    transaction_invoice = Transaction.find(params[:transaction_id]).invoice
    render json: InvoiceSerializer.new(transaction_invoice)
  end
end