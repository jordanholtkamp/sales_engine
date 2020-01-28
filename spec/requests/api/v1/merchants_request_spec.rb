require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:random_merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(10)
  end
end