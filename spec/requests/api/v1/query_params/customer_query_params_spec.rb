require 'rails_helper'

describe 'Customer query params API' do
  before :each do
    @customer_1 = create(:random_customer)  
    @customer_2 = create(:random_customer)  
    @customer_3 = create(:random_customer)  
    @customer_4 = create(:random_customer)  
    @customer_5 = create(:random_customer)  
    @customer_6 = create(:random_customer)  
    @customer_7 = create(:random_customer)  
    @customer_8 = create(:random_customer)  
    @customer_9 = create(:random_customer)  
    @customer_10 = create(:random_customer)  
  end

  it 'can find first customer by id' do
    get "/api/v1/customers/find?id=#{@customer_1.id}"

    expect(response).to be_successful

    found_customer = JSON.parse(response.body)['data']
    attributes = found_customer['attributes']

    expect(attributes['id']).to eq(@customer_1.id)
    expect(attributes['first_name']).to eq(@customer_1.first_name)
    expect(attributes['last_name']).to eq(@customer_1.last_name)
  end

  it 'can find first customer by first name' do
    get "/api/v1/customers/find?first_name=#{@customer_4.first_name}"

    expect(response).to be_successful

    found_customer = JSON.parse(response.body)['data']
    attributes = found_customer['attributes']

    expect(attributes['id']).to eq(@customer_4.id)
    expect(attributes['first_name']).to eq(@customer_4.first_name)
    expect(attributes['last_name']).to eq(@customer_4.last_name)
  end

  it 'can find first customer by last name' do
    get "/api/v1/customers/find?last_name=#{@customer_6.last_name}"

    expect(response).to be_successful

    found_customer = JSON.parse(response.body)['data']
    attributes = found_customer['attributes']

    expect(attributes['id']).to eq(@customer_6.id)
    expect(attributes['first_name']).to eq(@customer_6.first_name)
    expect(attributes['last_name']).to eq(@customer_6.last_name)
  end

  it 'can find first customer by created at' do
    new_customer = create(:random_customer, created_at: '2020-01-31 02:52:18')
    get "/api/v1/customers/find?created_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_customer = JSON.parse(response.body)['data']
    attributes = found_customer['attributes']

    expect(attributes['id']).to eq(new_customer.id)
    expect(attributes['first_name']).to eq(new_customer.first_name)
    expect(attributes['last_name']).to eq(new_customer.last_name)
  end

  it 'can find first customer by updated at' do
    new_customer = create(:random_customer, updated_at: '2020-01-31 02:52:18')
    get "/api/v1/customers/find?updated_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_customer = JSON.parse(response.body)['data']
    attributes = found_customer['attributes']

    expect(attributes['id']).to eq(new_customer.id)
    expect(attributes['first_name']).to eq(new_customer.first_name)
    expect(attributes['last_name']).to eq(new_customer.last_name)
  end

  it 'can find all customers by id' do
    get "/api/v1/customers/find_all?id=#{@customer_4.id}"

    expect(response).to be_successful

    found_customers = JSON.parse(response.body)['data']
    expect(found_customers.count).to eq(1)
    attributes = found_customers.first['attributes']

    expect(attributes['id']).to eq(@customer_4.id)
    expect(attributes['first_name']).to eq(@customer_4.first_name)
    expect(attributes['last_name']).to eq(@customer_4.last_name)
  end

  it 'can find all customers by first_name' do
    same_name = @customer_1.first_name
    new_customer = create(:random_customer, first_name: same_name)

    get "/api/v1/customers/find_all?first_name=#{new_customer.first_name}"
    
    expect(response).to be_successful

    found_customers = JSON.parse(response.body)['data']
    expect(found_customers.count).to eq(2)
    attributes = found_customers.first['attributes']

    expect(attributes['id']).to eq(@customer_1.id)
    expect(attributes['first_name']).to eq(@customer_1.first_name)
    expect(attributes['last_name']).to eq(@customer_1.last_name)
  end

  it 'can find all customers by last name' do
    same_name = @customer_1.last_name
    new_customer = create(:random_customer, last_name: same_name)

    get "/api/v1/customers/find_all?last_name=#{new_customer.last_name}"
    
    expect(response).to be_successful

    found_customers = JSON.parse(response.body)['data']
    expect(found_customers.count).to eq(2)
    attributes = found_customers.first['attributes']

    expect(attributes['id']).to eq(@customer_1.id)
    expect(attributes['first_name']).to eq(@customer_1.first_name)
    expect(attributes['last_name']).to eq(@customer_1.last_name)
  end

  it 'can find all customers by created at' do
    new_customer = create(:random_customer, created_at: '2020-01-31 02:52:18')

    get "/api/v1/customers/find_all?created_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_customers = JSON.parse(response.body)['data']
    expect(found_customers.count).to eq(1)
    attributes = found_customers.first['attributes']

    expect(attributes['id']).to eq(new_customer.id)
    expect(attributes['first_name']).to eq(new_customer.first_name)
    expect(attributes['last_name']).to eq(new_customer.last_name)
  end

  it 'can find all customers by updated at' do
    new_customer = create(:random_customer, updated_at: '2020-01-31 02:52:18')

    get "/api/v1/customers/find_all?updated_at=2020-01-31_02:52:18"
    
    expect(response).to be_successful

    found_customers = JSON.parse(response.body)['data']
    expect(found_customers.count).to eq(1)
    attributes = found_customers.first['attributes']

    expect(attributes['id']).to eq(new_customer.id)
    expect(attributes['first_name']).to eq(new_customer.first_name)
    expect(attributes['last_name']).to eq(new_customer.last_name)
  end
end