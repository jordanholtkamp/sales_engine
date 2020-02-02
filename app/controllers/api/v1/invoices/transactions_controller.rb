class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    invoice_transactions = Invoice.find(params[:invoice_id]).transactions
    render json: TransactionSerializer.new(invoice_transactions)
  end
end