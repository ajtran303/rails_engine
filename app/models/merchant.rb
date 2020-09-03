class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.search(params)
    find_by(params) ||
    fuzzy_find(params) ||
    find_by_date(params)
  end

  def self.fuzzy_find(params)
    return nil unless params[:name]

    attribute = params.keys.first
    query_fragment = params[attribute].downcase
    where("lower(#{attribute}) like ?", "%#{query_fragment}%").first
  end

  def self.find_by_date(params)
    return nil unless params[:updated_at] || params[:created_at]

    attribute = params.keys.first
    date = params[attribute]
    where("date(#{attribute}) = ?", date).first
  end

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
