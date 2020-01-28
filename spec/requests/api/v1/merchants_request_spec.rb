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

  it
end