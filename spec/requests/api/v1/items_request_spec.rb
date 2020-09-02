require "rails_helper"

RSpec.describe "Items API" do
  it "sends one item" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: :true)
    expect(item[:data][:id]).to eq(id.to_s)
  end
end
