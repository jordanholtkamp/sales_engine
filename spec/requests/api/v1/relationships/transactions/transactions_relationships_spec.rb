require 'rails_helper'

describe 'Transaction relationship API' do
  it 'can return associated invoice' do
    merchant = create(:random_merchant)
    customer = create(:random_customer)

    invoice_1 = Invoice.create!(customer: customer, merchant: merchant, status: 0)
    invoice_2 = Invoice.create!(customer: customer, merchant: merchant, status: 0)

    transaction_1 = create(:transaction, result: 0, invoice: invoice_1)
    transaction_2 = create(:transaction, result: 0, invoice: invoice_2)

    get "/api/v1/transactions/#{transaction_1.id}/invoice"

    expect(response).to be_successful

    invoice_data = JSON.parse(response.body)['data']

    expect(invoice_data['attributes']['id']).to eq(invoice_1.id)
  end
end