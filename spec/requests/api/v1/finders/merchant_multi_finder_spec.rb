require "rails_helper"

RSpec.describe "Merchant Multi Finder API" do
  def parse_body(response)
    JSON.parse(response.body, symbolize_names: :true)
  end

  before :each do
    @merchant1 = create(:merchant, name: "Ribs", id: 1)
    @merchant2 = create(:merchant, name: "Spare Ribs", id: 2)

    @expected_json =
    {
      "data": [
        {
          :id=>"#{@merchant1.id}",
          :type=>"merchant",
          :attributes=>{:name=>"#{@merchant1.name}"}
        },
        {
          :id=>"#{@merchant2.id}",
          :type=>"merchant",
          :attributes=>{:name=>"#{@merchant2.name}"}
        }
      ]
    }
    end

  describe "find all by name" do
    it "partial" do
      get "/api/v1/merchants/find_all?name=#{"rib"}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
   end

  describe "find all by id" do
    it "exact" do
      get "/api/v1/merchants/find_all?id=#{@merchant1.id}"
      json = parse_body(response)
      expected = {"data":
                    [{:id=>"#{@merchant1.id}",
                      :type=>"merchant",
                      :attributes=>{
                        :name=>"#{@merchant1.name}"}}]}

      expect(json).to eq(expected)
    end
  end

  describe "find all by updated_at" do
    it "exact" do
      get "/api/v1/merchants/find_all?updated_at=#{@merchant1.updated_at}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end

  describe "find all by created_at" do
    it "exact" do
      get "/api/v1/merchants/find_all?created_at=#{@merchant1.created_at}"
      json = parse_body(response)
      expect(json).to eq(@expected_json)
    end
  end
end
