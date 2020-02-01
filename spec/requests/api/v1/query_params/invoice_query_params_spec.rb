require 'rails_helper'

describe 'Invoice Query Param API' do
  before :each do
    @customer_1 = create(:random_customer)
    @customer_2 = create(:random_customer)

    @merchant_1 = create(:random_merchant)
    @merchant_2 = create(:random_merchant)

    @invoice_1 = Invoice.create!(customer: @customer_1, merchant: @merchant_1, status: 0)
    @invoice_2 = Invoice.create!(customer: @customer_1, merchant: @merchant_2, status: 0)
    @invoice_3 = Invoice.create!(customer: @customer_2, merchant: @merchant_1, status: 0)
    @invoice_4 = Invoice.create!(customer: @customer_2, merchant: @merchant_2, status: 0)
    @invoice_5 = Invoice.create!(customer: @customer_1, merchant: @merchant_1, status: 0)
    @invoice_6 = Invoice.create!(customer: @customer_2, merchant: @merchant_1, status: 0)
    @invoice_7 = Invoice.create!(customer: @customer_2, merchant: @merchant_2, status: 0)
    @invoice_8 = Invoice.create!(customer: @customer_1, merchant: @merchant_2, status: 0)
  end

  it 'can find first invoice by id' do
    get "/api/v1/invoices/find?id=#{@invoice_4.id}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@invoice_4.id)
    expect(attributes['merchant_id']).to eq(@invoice_4.merchant_id)
    expect(attributes['customer_id']).to eq(@invoice_4.customer_id)
    expect(attributes['status']).to eq(@invoice_4.status)
  end

  it 'can find first invoice by merchant id' do
    get "/api/v1/invoices/find?merchant_id=#{@invoice_5.merchant_id}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@invoice_1.id)
    expect(attributes['merchant_id']).to eq(@invoice_1.merchant_id)
    expect(attributes['customer_id']).to eq(@invoice_1.customer_id)
    expect(attributes['status']).to eq(@invoice_1.status)
  end

  it 'can find first instance by customer id' do
    get "/api/v1/invoices/find?customer=#{@invoice_2.customer_id}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@invoice_1.id)
    expect(attributes['merchant_id']).to eq(@invoice_1.merchant_id)
    expect(attributes['customer_id']).to eq(@invoice_1.customer_id)
    expect(attributes['status']).to eq(@invoice_1.status)
  end

  it 'can find first instance by status' do
    get "/api/v1/invoices/find?status=0"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@invoice_1.id)
    expect(attributes['merchant_id']).to eq(@invoice_1.merchant_id)
    expect(attributes['customer_id']).to eq(@invoice_1.customer_id)
    expect(attributes['status']).to eq(@invoice_1.status)
  end

  it 'can find first instance by created at' do
    new_invoice = Invoice.create!(customer: @customer_1, merchant: @merchant_1, status: 0, created_at: '2020-01-31 02:52:18')
    get "/api/v1/invoices/find?created_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(new_invoice.id)
    expect(attributes['merchant_id']).to eq(new_invoice.merchant_id)
    expect(attributes['customer_id']).to eq(new_invoice.customer_id)
    expect(attributes['status']).to eq(new_invoice.status)
  end

  it 'can find first instance by updated at' do
    new_invoice = Invoice.create!(customer: @customer_1, merchant: @merchant_1, status: 0, updated_at: '2020-01-31 02:52:18')
    get "/api/v1/invoices/find?updated_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(new_invoice.id)
    expect(attributes['merchant_id']).to eq(new_invoice.merchant_id)
    expect(attributes['customer_id']).to eq(new_invoice.customer_id)
    expect(attributes['status']).to eq(new_invoice.status)
  end

  it 'can find all instances by id' do
    get "/api/v1/invoices/find_all?id=#{@invoice_4.id}"

    expect(response).to be_successful

    found_items = JSON.parse(response.body)['data']
    expect(found_items.count).to eq(1)
    attributes = found_items.first['attributes']

    expect(attributes['id']).to eq(@invoice_4.id)
    expect(attributes['merchant_id']).to eq(@invoice_4.merchant_id)
    expect(attributes['customer_id']).to eq(@invoice_4.customer_id)
    expect(attributes['status']).to eq(@invoice_4.status)
  end

  it 'can find all instances by merchant_id' do
    get "/api/v1/invoices/find_all?merchant_id=#{@invoice_6.merchant_id}"

    expect(response).to be_successful

    found_items = JSON.parse(response.body)['data']
    expect(found_items.count).to eq(4)
    attributes = found_items.first['attributes']

    expect(attributes['id']).to eq(@invoice_1.id)
    expect(attributes['merchant_id']).to eq(@invoice_1.merchant_id)
    expect(attributes['customer_id']).to eq(@invoice_1.customer_id)
    expect(attributes['status']).to eq(@invoice_1.status)
  end
end