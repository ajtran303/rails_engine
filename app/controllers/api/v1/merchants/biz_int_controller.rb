class Api::V1::Merchants::BizIntController < ApplicationController
  def merchant_revenue
    revenue = Merchant.find(params[:id]).total_revenue
    render json: RevenueSerializer.new(revenue).to_h
  end

  def most_revenue
    merchants = Merchant.merchants_with_most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants).serialized_json
  end

  def most_items
    merchants = Merchant.merchants_with_most_items_sold(params[:quantity])
    render json: MerchantSerializer.new(merchants).serialized_json
  end
end
