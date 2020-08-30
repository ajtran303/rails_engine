require "rails_helper"

RSpec.describe Merchant do
  describe "validations" do
    it { should validate_presence_of :name }
  end
  describe "associations" do
    it { should have_many :items }
    it { should have_many :invoices }
  end
end
