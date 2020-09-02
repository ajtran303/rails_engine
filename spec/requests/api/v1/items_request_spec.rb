require "rails_helper"

RSpec.describe "Items API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  it "sends one item" do
    id = create(:item).id
    get "/api/v1/items/#{id}"
    expect(response).to be_successful

    item = parse_body(response)
    expect(item[:data][:id]).to eq(id.to_s)
    expect(item[:data][:type]).to eq("item")
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes]).to have_key(:merchant_id)
  end

  it "sends a list of all items" do
    items_list = create_list(:item, 3)
    get "/api/v1/items"
    expect(response).to be_successful

    items = parse_body(response)

    expect(items[:data].size).to eq(3)

    items[:data].each_with_index do |item, n|
      expect(item[:id]).to eq(items_list[n].id.to_s)
      expect(item[:type]).to eq("item")

      expect(item[:attributes][:name]).to eq(items_list[n].name)
      expect(item[:attributes][:description]).to eq(items_list[n].description)
      expect(item[:attributes][:unit_price]).to eq(items_list[n].unit_price)
      expect(item[:attributes][:merchant_id]).to eq(items_list[n].merchant_id)
    end
  end
end
