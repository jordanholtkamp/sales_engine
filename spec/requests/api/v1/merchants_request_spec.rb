require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:random_merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(10)

    expect(merchants["data"][0]["attributes"].keys).to include('id')
    expect(merchants["data"][0]["attributes"].keys).to include('name')
    expect(merchants["data"][0]["attributes"].keys).to_not include('created_at')
    expect(merchants["data"][0]["attributes"].keys).to_not include('updated_at')
  end

  it 'can send a single merchant' do
    merchants = create_list(:random_merchant, 10)
    first_merchant = merchants.first

    get "/api/v1/merchants/#{first_merchant.id}"

    expect(response).to be_successful

    parsed_merchant = JSON.parse(response.body)["data"]["attributes"]
    expect(parsed_merchant["id"]).to eq(first_merchant.id)
  end
end