require "rails_helper"

RSpec.describe "Merchant Single Finder API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  before :each do
    @merchant = create(:merchant)
    @expected_json = {:data=>{:id=>"#{@merchant.id}", :type=>"merchant", :attributes=>{:name=>"#{@merchant.name}"}}}
  end

  describe "find by name" do
    it "exact" do
      get "/api/v1/merchants/find?name=#{@merchant.name}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end

    it "partial" do
      get "/api/v1/merchants/find?name=#{@merchant.name[0..1]}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
   end

  describe "find by id" do
    it "exact" do
      get "/api/v1/merchants/find?id=#{@merchant.id}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find by updated_at" do
    it "exact" do
      get "/api/v1/merchants/find?updated_at=#{@merchant.updated_at}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find by created_at" do
    it "exact" do
      get "/api/v1/merchants/find?created_at=#{@merchant.created_at}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end
end
