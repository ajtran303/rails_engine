require "rails_helper"

RSpec.describe InvoiceItem do
  describe "validations" do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
  end
  describe "associations" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end
end
