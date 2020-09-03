class Api::V1::Items::SearchController < BaseSearchController
  def show
    item = Item.search(query_params)
    render json: ItemSerializer.new(item).serialized_json
  end
end
