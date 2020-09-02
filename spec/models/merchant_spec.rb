require "rails_helper"

RSpec.describe Merchant do
  describe "validations" do
    it { should validate_presence_of :name }
  end
  describe "associations" do
    it { should have_many :items }
    it { should have_many :invoices }
  end
  describe "#instance methods" do
    it "#total_revenue" do
      merchant1 = create(:merchant)
      item1 = create(:item, merchant: merchant1, unit_price: 100.0)

      # revenue earned
      invoice1 = create(:invoice, merchant: merchant1, status: "shipped")
      create(:invoice_item, invoice: invoice1, item: item1, quantity: 2, unit_price: 100.0)
      create(:purchase, invoice: invoice1, result: "success")

      # revenue not earned
      invoice2 = create(:invoice, merchant: merchant1, status: "not_shipped")
      create(:invoice_item, invoice: invoice2, item: item1, quantity: 3, unit_price: 100.0)
      create(:purchase, invoice: invoice2, result: "failed")

      expect(merchant1.total_revenue).to eq(200.0)
    end
  end
end
