class Api::V1::Items::MerchantsController < ApplicationController
  def index
    merchant = Item.find(params[:id]).merchant
    render json: MerchantSerializer.new(merchant).serialized_json
  end
end
