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

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    render json: MerchantSerializer.new(merchant).serialized_json
  end

  def destroy
    merchant = Merchant.find(params[:id])
    merchant.destroy
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
