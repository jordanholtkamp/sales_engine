require 'rails_helper'

describe 'Customer relationships API' do
  before :each do
    @customer = create(:random_customer)
    @customer_2 = create(:random_customer)

    merchant = create(:random_merchant)

    @invoice_1 = Invoice.create!(customer: @customer, merchant: merchant, status: 0)
    @invoice_2 = Invoice.create!(customer: @customer, merchant: merchant, status: 0)
    @invoice_3 = Invoice.create!(customer: @customer_2, merchant: merchant, status: 0)


  end

  it 'can return all associated invoices' do
    get "/api/v1/customers/#{@customer.id}/invoices"

    expect(response).to be_successful

    found_invoices = JSON.parse(response.body)['data']
    expect(found_invoices.count).to eq(2)
    
    expect(found_invoices.first['attributes']['id']).to eq(@invoice_1.id)
    expect(found_invoices.last['attributes']['id']).to eq(@invoice_2.id)
  end

  it 'can return all associated transactions' do
    transaction_1 = create(:transaction, result: 0, invoice: @invoice_1)
    transaction_2 = create(:transaction, result: 0, invoice: @invoice_2)
    transaction_3 = create(:transaction, result: 0, invoice: @invoice_1)
    transaction_4 = create(:transaction, result: 0, invoice: @invoice_3)

    get "/api/v1/customers/#{@customer.id}/transactions"

    expect(response).to be_successful

    found_transactions = JSON.parse(response.body)['data']

    expect(found_transactions.count).to eq(3)
    expect(found_transactions.first['attributes']['id']).to eq(transaction_1.id)
    expect(found_transactions.last['attributes']['id']).to eq(transaction_3.id)
  end
end