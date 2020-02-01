class Api::V1::Transactions::FindController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.find_by(transaction_params))
  end

  def index
    if params['invoice_id']
      render json: TransactionSerializer.new(Transaction.find_all_by_invoice(transaction_params))
    else
      render json: TransactionSerializer.new(Transaction.find_all(transaction_params))
    end
  end
  

  private
  def transaction_params
    params.permit(:id, :invoice_id, :result, :credit_card_number, :created_at, :updated_at)
  end
end