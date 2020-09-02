require "rails_helper"

RSpec.describe "Get Item Merchant API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  it "sends the merchant associated with an item" do
    item = create(:item)
    merchant = item.merchant

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful

    json = parse_body(response)
    expect(json[:data][:id]).to eq(merchant.id.to_s)
    expect(json[:data][:type]).to eq("merchant")
    expect(json[:data][:attributes][:name]).to eq(merchant.name)
  end
end
