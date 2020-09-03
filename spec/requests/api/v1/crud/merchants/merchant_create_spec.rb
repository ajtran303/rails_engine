require "rails_helper"

RSpec.describe "Create Merchants CRUD API" do
  it "can create a merchant" do
    new_merchant = build_stubbed(:merchant)
    expect(Merchant.count).to eq(0)

    merchant_params = {name: new_merchant.name}
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant_params)

    expect(Merchant.count).to eq(1)
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end
end
