require "rails_helper"

RSpec.describe "Item Multi Finder API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  before :each do
    merchant = create(:merchant, id: 1)
    @item1 = create(:item, name: "Ribs", description: "There are extra.", unit_price: 14.39, merchant: merchant)
    @item2 = create(:item, name: "Spare Ribs", description: "There are more extra.", unit_price: 14.39, merchant: merchant)

    @expected_json =
    {
      "data": [
        {
          :id=>"#{@item1.id}",
          :type=>"item",
          :attributes=>{
            :name=>"#{@item1.name}",
            :description=>"#{@item1.description}",
            :unit_price=>@item1.unit_price,
            :merchant_id=>@item1.merchant_id}
        },
        {
          :id=>"#{@item2.id}",
          :type=>"item",
          :attributes=>{
            :name=>"#{@item2.name}",
            :description=>"#{@item2.description}",
            :unit_price=>@item2.unit_price,
            :merchant_id=>@item2.merchant_id}
        }
      ]
    }
    end

  describe "find all by name" do
    it "partial" do
      get "/api/v1/items/find_all?name=#{"rib"}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
   end

  describe "find all by description" do
    it "partial" do
      get "/api/v1/items/find_all?description=#{"extra"}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find all by unit_price" do
    it "exact" do
      get "/api/v1/items/find_all?unit_price=#{@item1.unit_price}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find all by id" do
    it "exact" do
      get "/api/v1/items/find_all?id=#{@item1.id}"
      json = parse_body(response)
      expected = {"data": [{:id=>"#{@item1.id}",
                            :type=>"item",
                            :attributes=>{
                              :name=>"#{@item1.name}",
                              :description=>"#{@item1.description}",
                              :unit_price=>@item1.unit_price,
                              :merchant_id=>@item1.merchant_id}}]}

      expect(json).to eq(expected)
    end
  end

  describe "find all by merchant_id" do
    it "exact" do
      get "/api/v1/items/find_all?merchant_id=#{@item1.merchant_id}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find all by updated_at" do
    it "exact" do
      get "/api/v1/items/find_all?updated_at=#{@item1.updated_at}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find all by created_at" do
    it "exact" do
      get "/api/v1/items/find_all?created_at=#{@item1.created_at}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end
end
