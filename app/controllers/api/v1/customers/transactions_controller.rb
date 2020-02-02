class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    customer_transactions = Customer.find(params[:customer_id]).transactions
    render json: TransactionSerializer.new(customer_transactions)
  end
end