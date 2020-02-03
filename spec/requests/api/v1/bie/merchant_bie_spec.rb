require 'rails_helper'

describe 'Merchant API' do
  before :each do
    @customer_1 = create(:random_customer)
    @customer_2 = create(:random_customer)
    @customer_3 = create(:random_customer)
    @customer_4 = create(:random_customer)
    @customer_5 = create(:random_customer)
  
    @merchant_1 = create(:random_merchant)
    @merchant_2 = create(:random_merchant)
    @merchant_3 = create(:random_merchant)
  
    @item_1 = create(:random_item, merchant: @merchant_1)
    @item_2 = create(:random_item, merchant: @merchant_2)
    @item_3 = create(:random_item, merchant: @merchant_3)
    @item_4 = create(:random_item, merchant: @merchant_1)
    @item_5 = create(:random_item, merchant: @merchant_2)
    @item_6 = create(:random_item, merchant: @merchant_3)
    @item_7 = create(:random_item, merchant: @merchant_1)
    @item_8 = create(:random_item, merchant: @merchant_2)
  
    @invoice_1 = Invoice.create!(customer: @customer_1, merchant: @merchant_1, status: 0)
    @invoice_2 = Invoice.create!(customer: @customer_2, merchant: @merchant_2, status: 0)
    @invoice_3 = Invoice.create!(customer: @customer_1, merchant: @merchant_3, status: 0)
    @invoice_4 = Invoice.create!(customer: @customer_1, merchant: @merchant_1, status: 0)
    @invoice_5 = Invoice.create!(customer: @customer_3, merchant: @merchant_2, status: 0)
    @invoice_6 = Invoice.create!(customer: @customer_4, merchant: @merchant_3, status: 0)
  
    @invoice_item_1 = InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: 10)
    @invoice_item_2 = InvoiceItem.create(item: @item_2, invoice: @invoice_2, quantity: 5, unit_price: 100)
    @invoice_item_3 = InvoiceItem.create(item: @item_3, invoice: @invoice_3, quantity: 20, unit_price: 20)
    @invoice_item_4 = InvoiceItem.create(item: @item_4, invoice: @invoice_4, quantity: 30, unit_price: 30)
    @invoice_item_5 = InvoiceItem.create(item: @item_5, invoice: @invoice_5, quantity: 25, unit_price: 50)
    @invoice_item_6 = InvoiceItem.create(item: @item_6, invoice: @invoice_6, quantity: 100, unit_price: 40)
    @invoice_item_7 = InvoiceItem.create(item: @item_7, invoice: @invoice_1, quantity: 50, unit_price: 20)
    @invoice_item_8 = InvoiceItem.create(item: @item_8, invoice: @invoice_2, quantity: 20, unit_price: 30)
    @invoice_item_9 = InvoiceItem.create(item: @item_1, invoice: @invoice_3, quantity: 10, unit_price: 50)
    @invoice_item_10 = InvoiceItem.create(item: @item_2, invoice: @invoice_4, quantity: 20, unit_price: 40)
  
    @transaction_1 = create(:transaction, result: 0, invoice: @invoice_1)
    @transaction_2 = create(:transaction, result: 0, invoice: @invoice_2)
    @transaction_3 = create(:transaction, result: 1, invoice: @invoice_3)
    @transaction_4 = create(:transaction, result: 0, invoice: @invoice_4)
    @transaction_5 = create(:transaction, result: 1, invoice: @invoice_5)
    @transaction_6 = create(:transaction, result: 0, invoice: @invoice_6)
  end
  it 'shows the most top x merchants in revenue' do
    get "/api/v1/merchants/most_revenue?quantity=1"

    expect(response).to be_successful

    merchant_data = JSON.parse(response.body)['data']

    expect(merchant_data.count).to eq(1)
    expect(merchant_data.first['attributes']['id']).to eq(@merchant_3.id)
  end
end