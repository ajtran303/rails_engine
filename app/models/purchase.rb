class Purchase < ApplicationRecord
  validates_presence_of :credit_card_number, :result

  belongs_to :invoice
  has_many :purchases, through: :invoice
end
