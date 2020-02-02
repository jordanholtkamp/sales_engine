require 'rails_helper'

describe 'Invoice relationship API' do
  before :each do
    @merchant = create(:random_merchant)
    @customer = create(:random_customer)
    @customer_2 = create(:random_customer)
    
    @invoice = Invoice.create!(customer: @customer, merchant: @merchant, status: 0)
    @invoice_2 = Invoice.create!(customer: @customer_2, merchant: @merchant, status: 0)

    @tran = create(:transaction, result: 0, invoice_id: @invoice.id)
    @tran_2 = create(:transaction, result: 0, invoice_id: @invoice.id)
    @tran_3 = create(:transaction, result: 0, invoice_id: @invoice_2.id)

    @item_1 = create(:random_item, merchant: @merchant)
    @item_2 = create(:random_item, merchant: @merchant)
    @item_3 = create(:random_item, merchant: @merchant)

    @invoice_item_1 = InvoiceItem.create!(item: @item_1, invoice: @invoice, quantity: 10, unit_price: 100)
    @invoice_item_2 = InvoiceItem.create!(item: @item_2, invoice: @invoice, quantity: 5, unit_price: 500)
    @invoice_item_3 = InvoiceItem.create!(item: @item_3, invoice: @invoice_2, quantity: 20, unit_price: 100)
    @invoice_item_4 = InvoiceItem.create!(item: @item_1, invoice: @invoice_2, quantity: 5, unit_price: 250)
    @invoice_item_5 = InvoiceItem.create!(item: @item_2, invoice: @invoice, quantity: 5, unit_price: 250)
  end

  describe 'Invoice transactions' do
    it 'can get all the transactions for an invoice' do
      get "/api/v1/invoices/#{@invoice.id}/transactions"

      expect(response).to be_successful

      transaction_data = JSON.parse(response.body)['data']

      expect(transaction_data.count).to eq(2)
      expect(transaction_data.first['attributes']['id']).to eq(@tran.id)
      expect(transaction_data.last['attributes']['id']).to eq(@tran_2.id)
    end
  end

  describe 'Invoice invoice_items' do
    it 'can get all the items for an invoice' do
      get "/api/v1/invoices/#{@invoice.id}/invoice_items"

      expect(response).to be_successful

      invoice_item_data = JSON.parse(response.body)['data']

      expect(invoice_item_data.count).to eq(3)

      expect(invoice_item_data.first['attributes']['id']).to eq(@invoice_item_1.id)
      expect(invoice_item_data.last['attributes']['id']).to eq(@invoice_item_5.id)  
      expect(invoice_item_data[1]['attributes']['id']).to eq(@invoice_item_2.id)  
    end
  end

  describe 'Invoice items' do
    it 'can get all items for an invoice' do
      get "/api/v1/invoices/#{@invoice.id}/items"
      
      expect(response).to be_successful

      item_data = JSON.parse(response.body)['data']

      expect(item_data.count).to eq(2)

      expect(item_data.first['attributes']['id']).to eq(@item_1.id)
      expect(item_data.last['attributes']['id']).to eq(@item_2.id)  
    end
  end

  describe 'Invoice Customer' do
    it 'can get the customer for an invoice' do
      get "/api/v1/invoices/#{@invoice.id}/customer"
      
      expect(response).to be_successful

      customer_data = JSON.parse(response.body)['data']

      expect(customer_data['attributes']['id']).to eq(@customer.id)
    end
  end

  describe 'Invoice Merchant' do
    it 'returns the associated merchant' do
      get "/api/v1/invoices/#{@invoice.id}/merchant"
      
      expect(response).to be_successful

      merchant_data = JSON.parse(response.body)['data']

      expect(merchant_data['attributes']['id']).to eq(@merchant.id)
    end
  end
end