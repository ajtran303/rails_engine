class Api::V1::Merchants::BizIntController < ApplicationController
  def merchant_revenue
    revenue = Merchant.find(params[:id]).total_revenue
    render json: RevenueSerializer.new(revenue).to_h
  end
end
