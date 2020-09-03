require "rails_helper"

RSpec.describe "Destroy Merchants CRUD API" do
  it "can destroy an merchant" do
    merchant = create(:merchant)
    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
