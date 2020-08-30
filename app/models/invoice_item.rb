class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity
  validates_numericality_of :quantity, only_integer: true, greater_than: 0
  validates_presence_of :unit_price
  validates_numericality_of :unit_price, greater_than: 0

  belongs_to :item
  belongs_to :invoice
end
