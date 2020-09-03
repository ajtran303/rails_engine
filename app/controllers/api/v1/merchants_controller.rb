class Api::V1::MerchantsController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id])).serialized_json
  end

  def index
    render json: MerchantSerializer.new(Merchant.all).serialized_json
  end

  def create
    merchant = Merchant.create(merchant_params)
    render json: MerchantSerializer.new(merchant).serialized_json
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
