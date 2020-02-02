require 'rails_helper'

describe 'Merchant Items API' do
  before :each do
    @merchant_1 = create(:random_merchant)
    @merchant_2 = create(:random_merchant)
  
    @item_1 = create(:random_item, merchant_id: @merchant_1.id)
    @item_2 = create(:random_item, merchant_id: @merchant_1.id)
    @item_3 = create(:random_item, merchant_id: @merchant_2.id)
  end
  it 'can get all of the items for a merchant' do
    get "/api/v1/merchants/#{@merchant_1.id}/items"
    
    expect(response).to be_successful

    item_data = JSON.parse(response.body)["data"]

    expect(item_data.length).to eq(2)
    expect(item_data[0]["attributes"]["id"]).to eq(@item_1.id)
    expect(item_data[1]["attributes"]["id"]).to eq(@item_2.id)
  end
end