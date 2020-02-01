require 'rails_helper'

describe 'Item Query Param API' do
  before :each do
    @merchant = create(:random_merchant)
    @item_1 = create(:random_item, merchant_id: @merchant.id)
    @item_2 = create(:random_item, merchant_id: @merchant.id)
    @item_3 = create(:random_item, merchant_id: @merchant.id)
    @item_4 = create(:random_item, merchant_id: @merchant.id)
    @item_5 = create(:random_item, merchant_id: @merchant.id)
    @item_6 = create(:random_item, merchant_id: @merchant.id)
  end
  
  it 'can find first item by id' do
    get "/api/v1/items/find?id=#{@item_1.id}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@item_1.id)
    expect(attributes['merchant_id']).to eq(@item_1.merchant_id)
    expect(attributes['name']).to eq(@item_1.name)
    expect(attributes['description']).to eq(@item_1.description)
    expect(attributes['unit_price']).to eq((@item_1.unit_price/100).to_s)
  end

  it 'can find first item by name' do
    get "/api/v1/items/find?name=#{@item_1.name}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@item_1.id)
    expect(attributes['merchant_id']).to eq(@item_1.merchant_id)
    expect(attributes['name']).to eq(@item_1.name)
    expect(attributes['description']).to eq(@item_1.description)
    expect(attributes['unit_price']).to eq((@item_1.unit_price/100).to_s)
  end

  it 'can find first item by description' do
    get "/api/v1/items/find?description=#{@item_1.description}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@item_1.id)
    expect(attributes['merchant_id']).to eq(@item_1.merchant_id)
    expect(attributes['name']).to eq(@item_1.name)
    expect(attributes['description']).to eq(@item_1.description)
    expect(attributes['unit_price']).to eq((@item_1.unit_price/100).to_s)
  end
  
  it 'can find first item by unit price' do
    x = (@item_1.unit_price/100).to_s

    get "/api/v1/items/find?unit_price=#{x}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@item_1.id)
    expect(attributes['merchant_id']).to eq(@item_1.merchant_id)
    expect(attributes['name']).to eq(@item_1.name)
    expect(attributes['description']).to eq(@item_1.description)
    expect(attributes['unit_price']).to eq((@item_1.unit_price/100).to_s)
  end

  it 'can find first item by merchant id' do
    get "/api/v1/items/find?merchant_id=#{@item_1.merchant_id}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@item_1.id)
    expect(attributes['merchant_id']).to eq(@item_1.merchant_id)
    expect(attributes['name']).to eq(@item_1.name)
    expect(attributes['description']).to eq(@item_1.description)
    expect(attributes['unit_price']).to eq((@item_1.unit_price/100).to_s)
  end

  it 'can find first item by created at' do
    new_item = create(:random_item, merchant_id: @merchant.id, created_at: '2020-01-31 02:52:18')
    get "/api/v1/items/find?created_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data']
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(new_item.id)
    expect(attributes['merchant_id']).to eq(new_item.merchant_id)
    expect(attributes['name']).to eq(new_item.name)
    expect(attributes['description']).to eq(new_item.description)
    expect(attributes['unit_price']).to eq((new_item.unit_price/100).to_s)
  end

  it 'can find all items by id' do
    get "/api/v1/items/find_all?id=#{@item_1.id}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)['data'].first
    attributes = found_item['attributes']

    expect(attributes['id']).to eq(@item_1.id)
    expect(attributes['merchant_id']).to eq(@item_1.merchant_id)
    expect(attributes['name']).to eq(@item_1.name)
    expect(attributes['description']).to eq(@item_1.description)
    expect(attributes['unit_price']).to eq((@item_1.unit_price/100).to_s)
  end

  it 'can find all items by name' do
    same_name = @item_1.name
    new_item = create(:random_item, merchant_id: @merchant.id, name: same_name)

    get "/api/v1/items/find_all?name=#{@item_1.name}"

    expect(response).to be_successful

    found_items = JSON.parse(response.body)['data']
    expect(found_items.count).to eq(2)

    attributes = found_items.last['attributes']

    expect(attributes['id']).to eq(new_item.id)
    expect(attributes['merchant_id']).to eq(new_item.merchant_id)
    expect(attributes['name']).to eq(new_item.name)
    expect(attributes['description']).to eq(new_item.description)
    expect(attributes['unit_price']).to eq((new_item.unit_price/100).to_s)
  end

  it 'can find all items by description' do
    same_description = @item_1.description
    new_item = create(:random_item, merchant_id: @merchant.id, description: same_description)

    get "/api/v1/items/find_all?description=#{@item_1.description}"

    expect(response).to be_successful

    found_items = JSON.parse(response.body)['data']
    expect(found_items.count).to eq(2)

    attributes = found_items.last['attributes']

    expect(attributes['id']).to eq(new_item.id)
    expect(attributes['merchant_id']).to eq(new_item.merchant_id)
    expect(attributes['name']).to eq(new_item.name)
    expect(attributes['description']).to eq(new_item.description)
    expect(attributes['unit_price']).to eq((new_item.unit_price/100).to_s)
  end

  it 'can find all items by unit price' do
    same_price = @item_1.unit_price
    new_item = create(:random_item, merchant_id: @merchant.id, unit_price: same_price)

    get "/api/v1/items/find_all?unit_price=#{(same_price/100).to_s}"

    expect(response).to be_successful

    found_items = JSON.parse(response.body)['data']
    expect(found_items.count).to eq(2)

    attributes = found_items.last['attributes']

    expect(attributes['id']).to eq(new_item.id)
    expect(attributes['merchant_id']).to eq(new_item.merchant_id)
    expect(attributes['name']).to eq(new_item.name)
    expect(attributes['description']).to eq(new_item.description)
    expect(attributes['unit_price']).to eq((new_item.unit_price/100).to_s)
  end

  it 'can find all by merchant_id' do
    get "/api/v1/items/find_all?merchant_id=#{@item_3.merchant_id}"

    expect(response).to be_successful

    found_items = JSON.parse(response.body)['data']
    expect(found_items.count).to eq(6)
  end

  it 'can find all items by created at' do
    new_item = create(:random_item, merchant_id: @merchant.id, created_at: '2020-01-31 02:52:18')
    get "/api/v1/items/find_all?created_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_items = JSON.parse(response.body)['data']
    expect(found_items.count).to eq(1)

    attributes = found_items.last['attributes']


    expect(attributes['id']).to eq(new_item.id)
    expect(attributes['merchant_id']).to eq(new_item.merchant_id)
    expect(attributes['name']).to eq(new_item.name)
    expect(attributes['description']).to eq(new_item.description)
    expect(attributes['unit_price']).to eq((new_item.unit_price/100).to_s)
  end

  it 'can find all items by updated at' do
    new_item = create(:random_item, merchant_id: @merchant.id, updated_at: '2020-01-31 02:52:18')
    get "/api/v1/items/find_all?updated_at=2020-01-31_02:52:18"

    expect(response).to be_successful

    found_items = JSON.parse(response.body)['data']
    expect(found_items.count).to eq(1)

    attributes = found_items.last['attributes']


    expect(attributes['id']).to eq(new_item.id)
    expect(attributes['merchant_id']).to eq(new_item.merchant_id)
    expect(attributes['name']).to eq(new_item.name)
    expect(attributes['description']).to eq(new_item.description)
    expect(attributes['unit_price']).to eq((new_item.unit_price/100).to_s)
  end
end