require 'rails_helper'

describe 'Merchant Query Params API' do
  it 'can find first instance by id' do
    merchants = create_list(:random_merchant, 10)
    first_merchant = merchants[0]

    get "/api/v1/merchants/find?id=#{first_merchant.id}"

    expect(response).to be_successful

    found_merchant = JSON.parse(response.body)['data']

    expect(found_merchant['attributes']['id']).to eq(first_merchant.id)
    expect(found_merchant['attributes']['name']).to eq(first_merchant.name)
  end

  it 'can find first instance by name' do
    merchants = create_list(:random_merchant, 10)
    last_merchant = merchants[9]

    get "/api/v1/merchants/find?name=#{last_merchant.name}"

    expect(response).to be_successful

    found_merchant = JSON.parse(response.body)['data']

    expect(found_merchant['attributes']['id']).to eq(last_merchant.id)
    expect(found_merchant['attributes']['name']).to eq(last_merchant.name)
  end

  it 'can find first instance by created at' do
    merchants = create_list(:random_merchant, 10)
    
    last_merchant = create :random_merchant, created_at: '2020-01-31 02:52:18'

    get "/api/v1/merchants/find?created_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_merchant = JSON.parse(response.body)['data']

    expect(found_merchant['attributes']['id']).to eq(last_merchant.id)
    expect(found_merchant['attributes']['name']).to eq(last_merchant.name)
  end

  it 'can find first instance by updated at' do
    merchants = create_list(:random_merchant, 10)
    
    last_merchant = create :random_merchant, updated_at: '2020-01-31 02:52:18'

    get "/api/v1/merchants/find?updated_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_merchant = JSON.parse(response.body)['data']

    expect(found_merchant['attributes']['id']).to eq(last_merchant.id)
    expect(found_merchant['attributes']['name']).to eq(last_merchant.name)
  end

  it 'can find all instances by id' do
    merchants = create_list(:random_merchant, 10)
    first_merchant = merchants.first

    get "/api/v1/merchants/find_all?id=#{first_merchant.id}"

    expect(response).to be_successful

    found_merchants = JSON.parse(response.body)['data']
    expect(found_merchants.count).to eq(1)

    attributes = found_merchants.first['attributes']

    expect(attributes['id']).to eq(first_merchant.id)
    expect(attributes['name']).to eq(first_merchant.name)
  end

  it 'can find all instances by name' do
    merchants = create_list(:random_merchant, 10)
    first_merchant = merchants.first
    name = first_merchant.name
    new_merchant = create(:random_merchant, name: name)

    get "/api/v1/merchants/find_all?name=#{first_merchant.name}"

    expect(response).to be_successful

    found_merchants = JSON.parse(response.body)['data']
    expect(found_merchants.count).to eq(2)

    attributes = found_merchants.first['attributes']
    other_attributes = found_merchants.last['attributes']

    expect(attributes['id']).to eq(first_merchant.id)
    expect(attributes['name']).to eq(first_merchant.name)

    expect(other_attributes['id']).to eq(new_merchant.id)
    expect(other_attributes['name']).to eq(new_merchant.name)
  end
end