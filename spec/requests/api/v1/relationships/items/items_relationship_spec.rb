require 'rails_helper'

describe 'Item relationship API' do
  before :each do
    customer = create(:random_customer)
    @merchant = create(:random_merchant)
    @merchant2 = create(:random_merchant)
    
    @invoice_1 = Invoice.create!(customer: customer, merchant: @merchant, status: 0)

    @item_1 = create(:random_item, merchant_id: @merchant.id)
    @item_2 = create(:random_item, merchant_id: @merchant2.id)

    @invoice_item_1 = InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: 10)
    @invoice_item_2 = InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 100, unit_price: 100)
    @invoice_item_3 = InvoiceItem.create(item: @item_2, invoice: @invoice_1, quantity: 100, unit_price: 100)
  end
  it 'returns associated invoice items' do
    get "/api/v1/items/#{@item_1.id}/invoice_items"

    expect(response).to be_successful

    invoice_item_data = JSON.parse(response.body)['data']

    expect(invoice_item_data.count).to eq(2)

    expect(invoice_item_data.first['attributes']['id']).to eq(@invoice_item_1.id)
    expect(invoice_item_data.last['attributes']['id']).to eq(@invoice_item_2.id)
  end

  it 'returns associated merchant' do
    get "/api/v1/items/#{@item_2.id}/merchant"
    
    expect(response).to be_successful

    merchant_data = JSON.parse(response.body)['data']

    expect(merchant_data['attributes']['id']).to eq(@merchant2.id)
  end
end