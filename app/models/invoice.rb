class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :merchant
  belongs_to :customer

  has_one :purchase

  has_many :invoice_items
  has_many :items, through: :invoice_items
end
