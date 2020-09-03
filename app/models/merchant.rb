class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :purchases, through: :invoices

  def self.search(params)
    return find_by(params) unless find_by(params).nil?
    return fuzzy_find(params).first unless fuzzy_find(params).nil?
    return find_by_date(params).first unless find_by_date(params).nil?
  end

  def self.search_all(params)
    return where(params) unless where(params).empty?
    return fuzzy_find(params) unless fuzzy_find(params).nil?
    return find_by_date(params) unless find_by_date(params).nil?
  end

  def self.fuzzy_find(params)
    return nil unless params[:name]

    attribute = params.keys.first
    query_fragment = params[attribute].downcase
    where("lower(#{attribute}) like ?", "%#{query_fragment}%")
  end

  def self.find_by_date(params)
    return nil unless params[:updated_at] || params[:created_at]

    attribute = params.keys.first
    date = params[attribute]
    where("date(#{attribute}) = ?", date)
  end

  def self.merchants_with_most_revenue(quantity_of_merchants)
    sum_aggregate = "SUM(invoice_items.quantity * invoice_items.unit_price)"
    select_query = "merchants.*, #{sum_aggregate} AS revenue"

    select(select_query)
      .joins(invoices: [:invoice_items, :purchases])
      .merge(Purchase.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .order("revenue DESC")
      .limit(quantity_of_merchants)
  end

  def self.merchants_with_most_items_sold(quantity_of_merchants)
    sum_aggregate = "SUM(invoice_items.quantity)"
    select_query = "merchants.*, #{sum_aggregate} AS items_sold"

    select(select_query)
      .joins(invoices: [:invoice_items, :purchases])
      .merge(Purchase.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .order("items_sold DESC")
      .limit(quantity_of_merchants)
  end

  def total_revenue
    sum_aggregate = "SUM(invoice_items.quantity * invoice_items.unit_price)"
    select_query = "invoices.*, #{sum_aggregate} AS revenue"

    invoices.select(select_query)
      .joins(:invoice_items, :purchases)
      .merge(Purchase.successful)
      .merge(Invoice.shipped)
      .group(:id)
      .sum(&:revenue)
  end
end
