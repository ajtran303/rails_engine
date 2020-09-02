require "rails_helper"

RSpec.describe Purchase do
  describe "validations" do
    it { should validate_presence_of :credit_card_number }
    # it { should validate_presence_of :credit_card_expiration_date }
    it { should validate_presence_of :result }
  end
  describe "associations" do
    it { should belong_to :invoice }
    it { should have_many(:purchases).through(:invoice) }
  end
end
