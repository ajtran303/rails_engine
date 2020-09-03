require "rails_helper"

RSpec.describe "Create Items CRUD API" do
  it "can create an item" do
    new_item = build_stubbed(:item, merchant: create(:merchant))
    expect(Item.count).to eq(0)

    item_params = {
                    name: new_item.name,
                    description: new_item.description,
                    unit_price: new_item.unit_price,
                    merchant_id: new_item.merchant_id
                  }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

    expect(Item.count).to eq(1)
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end
end
