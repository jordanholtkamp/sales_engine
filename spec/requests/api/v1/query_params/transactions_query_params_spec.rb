require 'rails_helper'

describe 'Transaction Query Param API' do
  before :each do
    merchant = create(:random_merchant)
    customer = create(:random_customer)

    @invoice_1 = Invoice.create!(customer: customer, merchant: merchant, status: 0)
    @invoice_2 = Invoice.create!(customer: customer, merchant: merchant, status: 0)

    @transaction_1 = create(:transaction, result: 0, invoice: @invoice_1)
    @transaction_2 = create(:transaction, result: 0, invoice: @invoice_2)
    @transaction_3 = create(:transaction, result: 0, invoice: @invoice_1)
    @transaction_4 = create(:transaction, result: 0, invoice: @invoice_2)
  end

  it 'can find the first transaction by id' do
    get "/api/v1/transactions/find?id=#{@transaction_1.id}"
    
    expect(response).to be_successful

    found_transaction = JSON.parse(response.body)['data']
    attributes = found_transaction['attributes']

    expect(attributes['id']).to eq(@transaction_1.id)
    expect(attributes['result']).to eq(@transaction_1.result)
    expect(attributes['invoice_id']).to eq(@transaction_1.invoice_id)
    expect(attributes['credit_card_number']).to eq(@transaction_1.credit_card_number)
  end

  it 'can find the first transaction by invoice id' do
    get "/api/v1/transactions/find?invoice_id=#{@transaction_3.invoice_id}"
    
    expect(response).to be_successful

    found_transaction = JSON.parse(response.body)['data']
    attributes = found_transaction['attributes']

    expect(attributes['id']).to eq(@transaction_1.id)
    expect(attributes['result']).to eq(@transaction_1.result)
    expect(attributes['invoice_id']).to eq(@transaction_1.invoice_id)
    expect(attributes['credit_card_number']).to eq(@transaction_1.credit_card_number)
  end

  it 'can find the first transaction by result' do
    get "/api/v1/transactions/find?result=#{@transaction_3.result}"
    
    expect(response).to be_successful

    found_transaction = JSON.parse(response.body)['data']
    attributes = found_transaction['attributes']

    expect(attributes['id']).to eq(@transaction_1.id)
    expect(attributes['result']).to eq(@transaction_1.result)
    expect(attributes['invoice_id']).to eq(@transaction_1.invoice_id)
    expect(attributes['credit_card_number']).to eq(@transaction_1.credit_card_number)
  end

  it 'can find the first transaction by credit card number' do
    get "/api/v1/transactions/find?credit_card_number=#{@transaction_3.credit_card_number}"
    
    expect(response).to be_successful

    found_transaction = JSON.parse(response.body)['data']
    attributes = found_transaction['attributes']

    expect(attributes['id']).to eq(@transaction_1.id)
    expect(attributes['result']).to eq(@transaction_1.result)
    expect(attributes['invoice_id']).to eq(@transaction_1.invoice_id)
    expect(attributes['credit_card_number']).to eq(@transaction_1.credit_card_number)
  end

  it 'can find the first transaction by created_at' do
    new_tran = create(:transaction, result: 0, invoice: @invoice_1, created_at: '2020-01-31 02:52:18')
    get "/api/v1/transactions/find?created_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_transaction = JSON.parse(response.body)['data']
    attributes = found_transaction['attributes']

    expect(attributes['id']).to eq(new_tran.id)
    expect(attributes['result']).to eq(new_tran.result)
    expect(attributes['invoice_id']).to eq(new_tran.invoice_id)
    expect(attributes['credit_card_number']).to eq(new_tran.credit_card_number)
  end

  it 'can find the first transaction by updated at' do
    new_tran = create(:transaction, result: 0, invoice: @invoice_1, updated_at: '2020-01-31 02:52:18')

    get "/api/v1/transactions/find?updated_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_transaction = JSON.parse(response.body)['data']
    attributes = found_transaction['attributes']

    expect(attributes['id']).to eq(new_tran.id)
    expect(attributes['result']).to eq(new_tran.result)
    expect(attributes['invoice_id']).to eq(new_tran.invoice_id)
    expect(attributes['credit_card_number']).to eq(new_tran.credit_card_number)
  end

  it 'can find all transactions by id' do
    get "/api/v1/transactions/find_all?id=#{@transaction_1.id}"
    
    expect(response).to be_successful

    found_transactions = JSON.parse(response.body)['data']
    expect(found_transactions.count).to eq(1)
    attributes = found_transactions.first['attributes']

    expect(attributes['id']).to eq(@transaction_1.id)
    expect(attributes['result']).to eq(@transaction_1.result)
    expect(attributes['invoice_id']).to eq(@transaction_1.invoice_id)
    expect(attributes['credit_card_number']).to eq(@transaction_1.credit_card_number)
  end

  it 'can find all transactions by invoice id' do
    get "/api/v1/transactions/find_all?invoice_id=#{@transaction_4.invoice_id}"
    
    expect(response).to be_successful

    found_transactions = JSON.parse(response.body)['data']

    expect(found_transactions.count).to eq(2)

    attributes = found_transactions.first['attributes']

    expect(attributes['id']).to eq(@transaction_2.id)
    expect(attributes['result']).to eq(@transaction_2.result)
    expect(attributes['invoice_id']).to eq(@transaction_2.invoice_id)
    expect(attributes['credit_card_number']).to eq(@transaction_2.credit_card_number)
  end

  it 'can find all transactions by result' do
    get "/api/v1/transactions/find_all?result=#{@transaction_4.result}"
    
    expect(response).to be_successful

    found_transactions = JSON.parse(response.body)['data']

    expect(found_transactions.count).to eq(4)

    attributes = found_transactions.first['attributes']

    expect(attributes['id']).to eq(@transaction_1.id)
    expect(attributes['result']).to eq(@transaction_1.result)
    expect(attributes['invoice_id']).to eq(@transaction_1.invoice_id)
    expect(attributes['credit_card_number']).to eq(@transaction_1.credit_card_number)
  end

  it 'can find all transactions by credit card number' do
    get "/api/v1/transactions/find_all?credit_card_number=#{@transaction_4.credit_card_number}"
    
    expect(response).to be_successful

    found_transactions = JSON.parse(response.body)['data']

    expect(found_transactions.count).to eq(4)

    attributes = found_transactions.first['attributes']

    expect(attributes['id']).to eq(@transaction_1.id)
    expect(attributes['result']).to eq(@transaction_1.result)
    expect(attributes['invoice_id']).to eq(@transaction_1.invoice_id)
    expect(attributes['credit_card_number']).to eq(@transaction_1.credit_card_number)
  end

  it 'can find all transactions by created at' do
    new_tran = create(:transaction, result: 0, invoice: @invoice_1, created_at: '2020-01-31 02:52:18')

    get "/api/v1/transactions/find_all?created_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_transactions = JSON.parse(response.body)['data']

    expect(found_transactions.count).to eq(1)

    attributes = found_transactions.first['attributes']

    expect(attributes['id']).to eq(new_tran.id)
    expect(attributes['result']).to eq(new_tran.result)
    expect(attributes['invoice_id']).to eq(new_tran.invoice_id)
    expect(attributes['credit_card_number']).to eq(new_tran.credit_card_number)
  end

  it 'can find all transactions by updated at' do
    new_tran = create(:transaction, result: 0, invoice: @invoice_1, updated_at: '2020-01-31 02:52:18')

    get "/api/v1/transactions/find_all?updated_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_transactions = JSON.parse(response.body)['data']

    expect(found_transactions.count).to eq(1)

    attributes = found_transactions.first['attributes']

    expect(attributes['id']).to eq(new_tran.id)
    expect(attributes['result']).to eq(new_tran.result)
    expect(attributes['invoice_id']).to eq(new_tran.invoice_id)
    expect(attributes['credit_card_number']).to eq(new_tran.credit_card_number)
  end
end