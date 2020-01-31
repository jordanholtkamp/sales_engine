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
end