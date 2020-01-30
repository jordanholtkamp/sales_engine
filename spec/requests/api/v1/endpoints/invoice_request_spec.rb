require 'rails_helper'

describe 'Invoice API' do
  it 'sends in a list of invoives' do
    customer = create(:random_customer)
    merchant = create(:random_merchant)

    invoice = Invoice.create!(status: 0, customer_id: customer.id, merchant_id: merchant.id)
    invoice_2 = Invoice.create!(status: 0, customer_id: customer.id, merchant_id: merchant.id)

    get '/api/v1/invoices'

    expect(response).to be_successful
    
    invoices = JSON.parse(response.body)["data"]
    expect(invoices[0]["attributes"]["customer_id"]).to eq(customer.id)
    expect(invoices[0]["attributes"]["merchant_id"]).to eq(merchant.id)
    expect(invoices[0]["attributes"].keys).to include("status")
    expect(invoices[0]["attributes"].keys).to include("id")
  end

  it 'sends a single invoice' do
    customer = create(:random_customer)
    merchant = create(:random_merchant)

    invoice = Invoice.create!(status: 0, customer_id: customer.id, merchant_id: merchant.id)
    invoice_2 = Invoice.create!(status: 0, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/invoices/#{invoice.id}"

    expect(response).to be_successful
    parsed_invoice = JSON.parse(response.body)["data"]

    expect(parsed_invoice["attributes"]["id"]).to eq(invoice.id)
    expect(parsed_invoice["attributes"]["status"]).to eq("shipped")
    expect(parsed_invoice["attributes"]["customer_id"]).to eq(invoice.customer_id)
    expect(parsed_invoice["attributes"]["merchant_id"]).to eq(invoice.merchant_id)
  end
end