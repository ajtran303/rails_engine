require "rails_helper"

RSpec.describe "Destroy Items CRUD API" do
  it "can destroy an item" do
    item = create(:item, merchant: create(:merchant))
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
