require "rails_helper"

RSpec.describe "Merchants API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  it "sends one merchant" do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"
    expect(response).to be_successful

    item = parse_body(response)
    expect(item[:data][:id]).to eq(id.to_s)
    expect(item[:data][:type]).to eq("merchant")
    expect(item[:attributes]).to have_key(:name)
  end

  it "sends a list of all merchants" do
    merchants_list = create_list(:merchant, 3)
    get "/api/v1/merchants"
    expect(response).to be_successful

    merchants = parse_body(response)

    expect(merchants[:data].size).to eq(3)

    merchants[:data].each_with_index do |merchant, n|
      expect(merchant[:id]).to eq(merchants_list[n].id.to_s)
      expect(merchant[:type]).to eq("merchant")
      expect(merchant[:attributes][:name]).to eq(merchants_list[n].name)
    end
  end
end
