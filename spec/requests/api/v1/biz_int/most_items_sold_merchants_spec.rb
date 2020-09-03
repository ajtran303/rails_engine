require "rails_helper"

RSpec.describe "Get Merchants with Most Items Sold API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  before :each do
    @merchant1 = create(:merchant)
    item = create(:item, merchant: @merchant1)
    invoice = create(:invoice, merchant: @merchant1, status: "shipped")
    sale = create(:invoice_item, invoice: invoice, item: item, quantity: 20, unit_price: item.unit_price)
    purchase = create(:purchase, invoice: invoice, result: "success")

    @merchant2 = create(:merchant)
    item = create(:item, merchant: @merchant2)
    invoice = create(:invoice, merchant: @merchant2, status: "shipped")
    sale = create(:invoice_item, invoice: invoice, item: item, quantity: 40, unit_price: item.unit_price)
    purchase = create(:purchase, invoice: invoice, result: "success")
  end

  it "sends the merchant with most sold items" do
    get "/api/v1/merchants/most_items?quantity=#{1}"
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
    get "/api/v1/merchants/most_items?quantity=#{2}"
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
