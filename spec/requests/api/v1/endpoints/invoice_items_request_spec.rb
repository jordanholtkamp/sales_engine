require 'rails_helper'

describe 'invoice items api' do
  before :each do
    @customer = create(:random_customer)
    @merchant = create(:random_merchant)

    @invoice = Invoice.create!(status: 0, customer_id: @customer.id, merchant_id: @merchant.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer.id, merchant_id: @merchant.id)

    @item_1 = create(:random_item, merchant_id: @merchant.id)
    @item_2 = create(:random_item, merchant_id: @merchant.id)

    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice, quantity: 10, unit_price: 1000)
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice, quantity: 5, unit_price: 1000)
    @invoice_item_3 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 20, unit_price: 1000)
  end
  
  it 'sends a list of invoice items' do
    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]
    
    expect(invoice_items.count).to eq(3)
    expect(invoice_items[1]["attributes"]["id"]).to eq(@invoice_item_2.id)
    expect(invoice_items[1]["attributes"]["invoice_id"]).to eq(@invoice_item_2.invoice.id)
    expect(invoice_items[1]["attributes"]["item_id"]).to eq(@invoice_item_2.item.id)
    expect(invoice_items[1]["attributes"]["quantity"]).to eq(@invoice_item_2.quantity)
    expect(invoice_items[1]["attributes"]["unit_price"]).to eq((@invoice_item_2.unit_price/100).to_s)
  end
end