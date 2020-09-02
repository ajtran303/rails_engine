require "rails_helper"

RSpec.describe "Get Merchant Items API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  it "sends all items associated with a merchant" do
    merchant = create(:merchant)
    expected_item_ids = create_list(:item, 3, merchant: merchant).map(&:id).sort

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful

    actual_items = parse_body(response)
    actual_item_ids = actual_items[:data].map do |item|
      item[:id].to_i
    end.sort

    expect(actual_item_ids).to eq(expected_item_ids)
  end
end
