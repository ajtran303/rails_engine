require "rails_helper"

RSpec.describe "Item Single Finder API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  before :each do
    merchant = create(:merchant, id: 1)
    @item = create(:item, name: "Ribs", description: "There are extra.", unit_price: 14.39, merchant: merchant)
    @expected_json = {:data=>{:id=>"#{@item.id}", :type=>"item", :attributes=>{:name=>"#{@item.name}", :description=>"#{@item.description}", :unit_price=>@item.unit_price, :merchant_id=>@item.merchant_id}}}
  end

  describe "find by name" do
    it "exact" do
      get "/api/v1/items/find?name=#{@item.name}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end

    it "partial" do
      get "/api/v1/items/find?name=#{@item.name[0..1]}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
   end

  describe "find by description" do
    it "exact" do
      get "/api/v1/items/find?description=#{@item.description}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end

    it "partial" do
      get "/api/v1/items/find?description=#{@item.description[0..6]}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find by unit_price" do
    it "exact" do
      get "/api/v1/items/find?unit_price=#{@item.unit_price}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find by id" do
    it "exact" do
      get "/api/v1/items/find?id=#{@item.id}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find by merchant_id" do
    it "exact" do
      get "/api/v1/items/find?merchant_id=#{@item.merchant_id}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find by updated_at" do
    it "exact" do
      get "/api/v1/items/find?updated_at=#{@item.updated_at}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find by created_at" do
    it "exact" do
      get "/api/v1/items/find?created_at=#{@item.created_at}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end
end
