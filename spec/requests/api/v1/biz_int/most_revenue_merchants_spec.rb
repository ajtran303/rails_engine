require "rails_helper"

RSpec.describe "Get Merchants with Most Revenue API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  before :each do
    @merchant1 = create(:merchant)
    item = create(:item, merchant: @merchant1, unit_price: 100.0)
    invoice = create(:invoice, merchant: @merchant1, status: "shipped")
    sale = create(:invoice_item, invoice: invoice, item: item, quantity: 2, unit_price: 90.0)
    purchase = create(:purchase, invoice: invoice, result: "success")

    @merchant2 = create(:merchant)
    item = create(:item, merchant: @merchant2, unit_price: 100.0)
    invoice = create(:invoice, merchant: @merchant2, status: "shipped")
    sale = create(:invoice_item, invoice: invoice, item: item, quantity: 2, unit_price: 100.0)
    purchase = create(:purchase, invoice: invoice, result: "success")
  end

  it "sends the merchant with most revenue" do
    get "/api/v1/merchants/most_revenue?quantity=#{1}"
    expect(response).to be_successful

    json = parse_body(response)

    expected =
    {
      "data": [
        {
          :id=>"#{@merchant2.id}",
          :type=>"merchant",
          :attributes=>{:name=>"#{@merchant2.name}"}
        }
      ]
    }

    expect(json).to eq(expected)
  end

  it "sends the merchant with most revenue" do
    get "/api/v1/merchants/most_revenue?quantity=#{2}"
    expect(response).to be_successful

    json = parse_body(response)

    expected =
    {
      "data": [
        {
          :id=>"#{@merchant2.id}",
          :type=>"merchant",
          :attributes=>{:name=>"#{@merchant2.name}"}
        },
        {
          :id=>"#{@merchant1.id}",
          :type=>"merchant",
          :attributes=>{:name=>"#{@merchant1.name}"}
        }
      ]
    }

    expect(json).to eq(expected)
  end
end
