require 'rails_helper'

describe 'Merchant Invoice API' do
  before :each do
    @merchant_1 = create(:random_merchant)
    @merchant_2 = create(:random_merchant)

    customer = create(:random_customer)

    @invoice_1 = Invoice.create!(customer: customer, merchant: @merchant_1, status: 0)
    @invoice_2 = Invoice.create!(customer: customer, merchant: @merchant_2, status: 0)
    @invoice_3 = Invoice.create!(customer: customer, merchant: @merchant_1, status: 0)
    @invoice_4 = Invoice.create!(customer: customer, merchant: @merchant_2, status: 0)
    @invoice_5 = Invoice.create!(customer: customer, merchant: @merchant_1, status: 0)
    @invoice_6 = Invoice.create!(customer: customer, merchant: @merchant_2, status: 0)
  end

  it 'can get all of the invoices for a merchant' do
    get "/api/v1/merchants/#{@merchant_2.id}/invoices"

    expect(response).to be_successful

    invoice_data = JSON.parse(response.body)['data']

    expect(invoice_data.count).to eq(3)
  end
end