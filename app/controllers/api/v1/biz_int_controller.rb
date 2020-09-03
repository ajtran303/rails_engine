class Api::V1::BizIntController < ApplicationController
  def revenue_over_time
    revenue = Merchant.revenue_between(params[:start], params[:end])
    render json: RevenueSerializer.new(revenue).to_h
  end
end
