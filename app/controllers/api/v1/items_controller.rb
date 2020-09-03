class Api::V1::ItemsController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find(params[:id])).serialized_json
  end

  def index
    render json: ItemSerializer.new(Item.all).serialized_json
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item).serialized_json
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    render json: ItemSerializer.new(item).serialized_json
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
