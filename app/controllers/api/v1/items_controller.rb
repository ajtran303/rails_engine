class Api::V1::ItemsController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find(params[:id])).serialized_json
  end

  def index
    render json: ItemSerializer.new(Item.all).serialized_json
  end
end
