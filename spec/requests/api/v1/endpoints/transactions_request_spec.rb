require 'rails_helper'

describe 'transaction api' do
  it 'sends a list of transactions' do
    customer = create(:random_customer)
    merchant = create(:random_merchant)

    invoice = Invoice.create!(status: 0, customer_id: customer.id, merchant_id: merchant.id)
    tran = create(:transaction, result: 0, invoice_id: invoice.id)
    tran_2 = create(:transaction, result: 0, invoice_id: invoice.id)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]

    expect(transactions.count).to eq(2)
    expect(transactions[0]["attributes"]["id"]).to eq(tran.id)
    expect(transactions[0]["attributes"]["result"]).to eq("success")
    expect(transactions[0]["attributes"]["credit_card_number"]).to eq(tran.credit_card_number)
  end

  it 'sends one transaction' do
    customer = create(:random_customer)
    merchant = create(:random_merchant)

    invoice = Invoice.create!(status: 0, customer_id: customer.id, merchant_id: merchant.id)
    tran = create(:transaction, result: 0, invoice_id: invoice.id)
    tran_2 = create(:transaction, result: 0, invoice_id: invoice.id)

    get "/api/v1/transactions/#{tran.id}"

    expect(response).to be_successful

    parsed_transaction = JSON.parse(response.body)["data"]

    expect(parsed_transaction["attributes"]["id"]).to eq(tran.id)
    expect(parsed_transaction["attributes"]["result"]).to eq("success")
  end
end