require "rails_helper"

RSpec.describe "Get Revenue for a Merchant API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  it "sends all items associated with a merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant, unit_price: 100.0)
    invoice = create(:invoice, merchant: merchant, status: "shipped")
    sale = create(:invoice_item, invoice: invoice, item: item, quantity: 2, unit_price: 100.0)
    purchase = create(:purchase, invoice: invoice, result: "success")

    get "/api/v1/merchants/#{merchant.id}/revenue"
    expect(response).to be_successful

    merchant_revenue = parse_body(response)
    expect(merchant_revenue[:data][:id]).to eq(nil)
    expect(merchant_revenue[:data][:attributes][:revenue]).to eq(200.0)
  end
end
