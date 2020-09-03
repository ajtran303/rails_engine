class Api::V1::Items::SearchController < BaseSearchController
  def show
    item = Item.search(query_params)
    render json: ItemSerializer.new(item).serialized_json
  end

  def index
    items = Item.search_all(query_params)
    render json: ItemSerializer.new(items).serialized_json
  end
end
