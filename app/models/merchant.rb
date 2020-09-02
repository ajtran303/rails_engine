class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def total_revenue
    select_sql = "invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue"
    merchant_invoices = self.invoices.select(select_sql)
      .joins(:invoice_items, :purchases)
      .where(purchases: {result: "success"}, invoices: {status: "shipped"})
      .group(:id)

    merchant_invoices.sum(&:revenue)
  end
end
