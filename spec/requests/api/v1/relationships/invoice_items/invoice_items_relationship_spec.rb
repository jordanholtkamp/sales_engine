require 'rails_helper'

describe 'Invoice Item Relationships' do
  before :each do
    customer = create(:random_customer)
    merchant = create(:random_merchant)

    @invoice_1 = Invoice.create!(customer: customer, merchant: merchant, status: 0)
    @invoice_2 = Invoice.create!(customer: customer, merchant: merchant, status: 0)

    @item_1 = create(:random_item, merchant_id: merchant.id)
    @item_2 = create(:random_item, merchant_id: merchant.id)

    @invoice_item_1 = InvoiceItem.create(item: @item_1, invoice: @invoice_1, quantity: 10, unit_price: 10)
    @invoice_item_2 = InvoiceItem.create(item: @item_2, invoice: @invoice_2, quantity: 100, unit_price: 100)
  end
 
  describe 'Invoice item invoice' do
    it 'returns the associated invoice' do
      get "/api/v1/invoice_items/#{@invoice_item_1.id}/invoice"
  
      expect(response).to be_successful
  
      invoice_data = JSON.parse(response.body)['data']
  
      expect(invoice_data['attributes']['id']).to eq(@invoice_1.id)
    end   
  end

  describe 'Item of an invoice item' do
    it 'returns the associated item' do
      get "/api/v1/invoice_items/#{@invoice_item_1.id}/item"
  
      expect(response).to be_successful
  
      item_data = JSON.parse(response.body)['data']
  
      expect(item_data['attributes']['id']).to eq(@item_1.id)
    end
  end
end