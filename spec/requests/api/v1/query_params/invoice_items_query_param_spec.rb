require 'rails_helper'

describe 'Invoice Items Query Param API' do
  before :each do
    @customer_1 = create(:random_customer)
    @merchant_1 = create(:random_merchant)
    
    @invoice_1 = Invoice.create!(customer: @customer_1, merchant: @merchant_1, status: 0)
    @invoice_2 = Invoice.create!(customer: @customer_1, merchant: @merchant_1, status: 0)

    @item_1 = create(:random_item, merchant_id: @merchant_1.id)
    @item_2 = create(:random_item, merchant_id: @merchant_1.id)

    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: 100)
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice_1, quantity: 5, unit_price: 500)
    @invoice_item_3 = InvoiceItem.create!(item: @item_2, invoice: @invoice_2, quantity: 20, unit_price: 100)
    @invoice_item_4 = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, quantity: 5, unit_price: 250)
  end

  it 'can find first invoice item by id' do
    get "/api/v1/invoice_items/find?id=#{@invoice_item_1.id}"
    
    expect(response).to be_successful

    found_invoice_item = JSON.parse(response.body)['data']
    attributes = found_invoice_item['attributes']

    expect(attributes['id']).to eq(@invoice_item_1.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_1.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_1.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_1.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_1.unit_price/100).to_s)
  end

  it 'can find first invoice item by invoice id' do
    get "/api/v1/invoice_items/find?invoice_id=#{@invoice_item_4.invoice_id}"
    
    expect(response).to be_successful

    found_invoice_item = JSON.parse(response.body)['data']
    attributes = found_invoice_item['attributes']

    expect(attributes['id']).to eq(@invoice_item_3.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_3.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_3.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_3.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_3.unit_price/100).to_s)
  end

  it 'can find first invoice item by item id' do
    get "/api/v1/invoice_items/find?item_id=#{@invoice_item_3.item_id}"
    
    expect(response).to be_successful

    found_invoice_item = JSON.parse(response.body)['data']
    attributes = found_invoice_item['attributes']

    expect(attributes['id']).to eq(@invoice_item_2.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_2.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_2.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_2.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_2.unit_price/100).to_s)
  end

  it 'can find first invoice item by quantity' do
    get "/api/v1/invoice_items/find?quantity=#{@invoice_item_4.quantity}"
    
    expect(response).to be_successful

    found_invoice_item = JSON.parse(response.body)['data']
    attributes = found_invoice_item['attributes']

    expect(attributes['id']).to eq(@invoice_item_2.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_2.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_2.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_2.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_2.unit_price/100).to_s)
  end

  it 'can find first invoice item by unit price' do
    get "/api/v1/invoice_items/find?unit_price=#{@invoice_item_4.unit_price/100}"
    
    expect(response).to be_successful

    found_invoice_item = JSON.parse(response.body)['data']
    attributes = found_invoice_item['attributes']

    expect(attributes['id']).to eq(@invoice_item_4.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_4.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_4.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_4.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_4.unit_price/100).to_s)
  end

  it 'can find first invoice item by created at' do
    new_invoice_item = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, quantity: 5, unit_price: 250, created_at: '2020-01-31 02:52:18')
    get "/api/v1/invoice_items/find?created_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_invoice_item = JSON.parse(response.body)['data']
    attributes = found_invoice_item['attributes']

    expect(attributes['id']).to eq(new_invoice_item.id)
    expect(attributes['invoice_id']).to eq(new_invoice_item.invoice_id)
    expect(attributes['item_id']).to eq(new_invoice_item.item_id)
    expect(attributes['quantity']).to eq(new_invoice_item.quantity)
    expect(attributes['unit_price']).to eq((new_invoice_item.unit_price/100).to_s)
  end

  it 'can find first invoice item by updated at' do
    new_invoice_item = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, quantity: 5, unit_price: 250, updated_at: '2020-01-31 02:52:18')
    get "/api/v1/invoice_items/find?updated_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_invoice_item = JSON.parse(response.body)['data']
    attributes = found_invoice_item['attributes']

    expect(attributes['id']).to eq(new_invoice_item.id)
    expect(attributes['invoice_id']).to eq(new_invoice_item.invoice_id)
    expect(attributes['item_id']).to eq(new_invoice_item.item_id)
    expect(attributes['quantity']).to eq(new_invoice_item.quantity)
    expect(attributes['unit_price']).to eq((new_invoice_item.unit_price/100).to_s)
  end

  it 'can find all invoice items by id' do
    get "/api/v1/invoice_items/find_all?id=#{@invoice_item_1.id}"

    expect(response).to be_successful

    found_invoice_items = JSON.parse(response.body)['data']
    expect(found_invoice_items.count).to eq(1)
    attributes = found_invoice_items.first['attributes']

    expect(attributes['id']).to eq(@invoice_item_1.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_1.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_1.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_1.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_1.unit_price/100).to_s)
  end

  it 'can find all invoice items by invoice id' do
    get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_item_4.invoice_id}"

    expect(response).to be_successful

    found_invoice_items = JSON.parse(response.body)['data']
    expect(found_invoice_items.count).to eq(2)
    attributes = found_invoice_items.first['attributes']

    expect(attributes['id']).to eq(@invoice_item_3.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_3.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_3.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_3.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_3.unit_price/100).to_s)
  end

  it 'can find all invoice items by item id' do
    get "/api/v1/invoice_items/find_all?item_id=#{@invoice_item_4.item_id}"

    expect(response).to be_successful

    found_invoice_items = JSON.parse(response.body)['data']
    expect(found_invoice_items.count).to eq(2)
    attributes = found_invoice_items.first['attributes']

    expect(attributes['id']).to eq(@invoice_item_1.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_1.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_1.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_1.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_1.unit_price/100).to_s)
  end

  it 'can find all invoice items by quantity' do
    get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item_4.quantity}"

    expect(response).to be_successful

    found_invoice_items = JSON.parse(response.body)['data']
    expect(found_invoice_items.count).to eq(2)
    attributes = found_invoice_items.first['attributes']

    expect(attributes['id']).to eq(@invoice_item_2.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_2.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_2.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_2.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_2.unit_price/100).to_s)
  end

  it 'can find all invoice items by unit_price' do
    get "/api/v1/invoice_items/find_all?unit_price=#{@invoice_item_3.unit_price/100}"

    expect(response).to be_successful

    found_invoice_items = JSON.parse(response.body)['data']
    expect(found_invoice_items.count).to eq(2)
    attributes = found_invoice_items.first['attributes']

    expect(attributes['id']).to eq(@invoice_item_1.id)
    expect(attributes['invoice_id']).to eq(@invoice_item_1.invoice_id)
    expect(attributes['item_id']).to eq(@invoice_item_1.item_id)
    expect(attributes['quantity']).to eq(@invoice_item_1.quantity)
    expect(attributes['unit_price']).to eq((@invoice_item_1.unit_price/100).to_s)
  end

  it 'can find all invoice items by created at' do
    new_invoice_item = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, quantity: 5, unit_price: 250, created_at: '2020-01-31 02:52:18')
    get "/api/v1/invoice_items/find_all?created_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_invoice_items = JSON.parse(response.body)['data']
    expect(found_invoice_items.count).to eq(1)
    attributes = found_invoice_items.first['attributes']

    expect(attributes['id']).to eq(new_invoice_item.id)
    expect(attributes['invoice_id']).to eq(new_invoice_item.invoice_id)
    expect(attributes['item_id']).to eq(new_invoice_item.item_id)
    expect(attributes['quantity']).to eq(new_invoice_item.quantity)
    expect(attributes['unit_price']).to eq((new_invoice_item.unit_price/100).to_s)
  end

  it 'can find all invoice items by created at' do
    new_invoice_item = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, quantity: 5, unit_price: 250, updated_at: '2020-01-31 02:52:18')
    anotha_one = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, quantity: 5, unit_price: 250, updated_at: '2020-01-31 02:52:18')
    get "/api/v1/invoice_items/find_all?updated_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_invoice_items = JSON.parse(response.body)['data']
    expect(found_invoice_items.count).to eq(2)
    attributes = found_invoice_items.last['attributes']

    expect(attributes['id']).to eq(anotha_one.id)
    expect(attributes['invoice_id']).to eq(anotha_one.invoice_id)
    expect(attributes['item_id']).to eq(anotha_one.item_id)
    expect(attributes['quantity']).to eq(anotha_one.quantity)
    expect(attributes['unit_price']).to eq((anotha_one.unit_price/100).to_s)
  end
end