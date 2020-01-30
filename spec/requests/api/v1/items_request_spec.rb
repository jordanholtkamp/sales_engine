require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    merchant = create(:random_merchant)
    merchant_2 = create(:random_merchant)

    item_1 = create(:random_item, merchant_id: merchant.id)
    item_2 = create(:random_item, merchant_id: merchant.id)
    item_3 = create(:random_item, merchant_id: merchant_2.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)

    expect(items["data"][0]["attributes"].keys).to include('id')
    expect(items["data"][0]["attributes"].keys).to include('name')
    expect(items["data"][0]["attributes"].keys).to include('description')
    expect(items["data"][0]["attributes"].keys).to include('unit_price')
    expect(items["data"][0]["attributes"].keys).to include('merchant_id')

    expect(items["data"][0]["attributes"].keys).to_not include('created_at')
    expect(items["data"][0]["attributes"].keys).to_not include('updated_at')
  end

  it 'sends a specific item' do
    merchant = create(:random_merchant)
    merchant_2 = create(:random_merchant)

    item_1 = create(:random_item, merchant_id: merchant.id)
    item_2 = create(:random_item, merchant_id: merchant.id)
    item_3 = create(:random_item, merchant_id: merchant_2.id)

    get "/api/v1/items/#{item_1.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)["data"]

    price_in_dollars = item_1.unit_price/100

    expect(item["attributes"]["id"]).to eq(item_1.id)
    expect(item["attributes"]["name"]).to eq(item_1.name)
    expect(item["attributes"]["description"]).to eq(item_1.description)
    expect(item["attributes"]["unit_price"]).to eq(price_in_dollars.to_s)
    expect(item["attributes"]["merchant_id"]).to eq(merchant.id)
  end
end