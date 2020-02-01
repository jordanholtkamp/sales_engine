require 'rails_helper'

describe 'Customer API' do
  it 'sends a list of customers' do
    create_list(:random_customer, 10)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)['data']

    expect(customers.count).to eq(10)
  end

  it 'sends a single customer' do
    custies = create_list(:random_customer, 10)
    customer_uno = custies[0]

    get "/api/v1/customers/#{customer_uno.id}"

    expect(response).to be_successful

    item_attrs = JSON.parse(response.body)['data']['attributes']

    expect(item_attrs['id']).to eq(custies[0].id)
    expect(item_attrs['first_name']).to eq(custies[0].first_name)
    expect(item_attrs['last_name']).to eq(custies[0].last_name)
  end
end