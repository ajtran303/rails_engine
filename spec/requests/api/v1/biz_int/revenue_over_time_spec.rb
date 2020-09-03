require "rails_helper"

RSpec.describe "Get All Revenue over a period of Time API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  before :each do
    @merchant1 = create(:merchant)
    item = create(:item, merchant: @merchant1, unit_price: 100.0)
    invoice1 = create(:invoice, merchant: @merchant1, status: "shipped", created_at: DateTime.now.prev_day.to_time)
    sale = create(:invoice_item, invoice: invoice1, item: item, quantity: 2, unit_price: 90.0)
    purchase = create(:purchase, invoice: invoice1, result: "success")

    @merchant2 = create(:merchant)
    item = create(:item, merchant: @merchant2, unit_price: 100.0)
    invoice2 = create(:invoice, merchant: @merchant2, status: "shipped", created_at: DateTime.now.next_day.to_time)
    sale = create(:invoice_item, invoice: invoice2, item: item, quantity: 2, unit_price: 100.0)
    purchase = create(:purchase, invoice: invoice2, result: "success")

    @start_date = invoice1.created_at.strftime("%Y-%m-%d")
    @end_date = invoice2.created_at.strftime("%Y-%m-%d")
  end

  it "Gets all merchants' revenue over a period of time" do
    get "/api/v1/revenue?start=#{@start_date}&end=#{@end_date}"
    expect(response).to be_successful

    total_revenue = parse_body(response)
    expect(total_revenue[:data][:id]).to eq(nil)
    expect(total_revenue[:data][:attributes][:revenue]).to eq(380.0)
  end
end
