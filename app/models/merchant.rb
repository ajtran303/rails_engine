class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def total_revenue
    sum_aggregate = "SUM(invoice_items.quantity * invoice_items.unit_price)"
    select_query = "invoices.*, #{sum_aggregate} AS revenue"

    merchant_invoices = self.invoices.select(select_query)
      .joins(:invoice_items, :purchases)
      .merge(Purchase.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .sum(&:revenue)
  end
end
