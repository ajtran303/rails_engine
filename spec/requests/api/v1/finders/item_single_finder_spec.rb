require "rails_helper"

RSpec.describe "Item Single Finder API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  before :each do
    @merchant = create(:merchant, id: 1)
    @item = create(:item, name: "Ribs", description: "There are extra.", unit_price: 14.39, merchant: merchant)
  end

  describe "find by name" do
    it "exact" do
      get "/api/v1/items/find?name=#{@item.name}"
    end

    it "partial" do
      get "/api/v1/items/find?name=#{@item.name[0..2]}"
    end
  end

  describe "find by description" do
    it "exact" do
      get "/api/v1/items/find?description=#{@item.description}"
    end

    it "partial" do
      get "/api/v1/items/find?description=#{@item.description[0..6]}"
    end
  end

  describe "find by unit_price" do
    it "exact" do
      get "/api/v1/items/find?unit_price=#{@item.unit_price}"
    end

    it "partial" do
      get "/api/v1/items/find?unit_price=#{@item.unit_price.round}"
    end
  end

  describe "find by merchant_id" do
    it "exact" do
      get "/api/v1/items/find?merchant_id=#{@item.merchant_id}"
    end

    # it "partial" do
    # end
  end

  describe "find by updated_at" do
    it "exact" do
      get "/api/v1/items/find?updated_at=#{@item.updated_at}"
    end

  #   it "partial" do
  #   end
  end

  describe "find by created_at" do
    it "exact" do
      get "/api/v1/items/find?created_at=#{@item.created_at}"
    end
  #
  #   it "partial" do
  #   end
  end
end
