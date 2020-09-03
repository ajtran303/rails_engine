class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price, greater_than: 0

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.search(params)
    find_by(params) ||
    fuzzy_find(params) ||
    find_by_date(params)
  end

  def self.fuzzy_find(params)
    return nil unless params[:name] || params[:description]

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
end
