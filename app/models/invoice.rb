class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :merchant
  belongs_to :customer

  has_many :purchases
  has_many :invoice_items
  has_many :items, through: :invoice_items

  scope :shipped, -> { where(status: "shipped") }
end
