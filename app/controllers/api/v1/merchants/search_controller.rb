class Api::V1::Merchants::SearchController < BaseSearchController
  def show
    merchant = Merchant.search(query_params)
    render json: MerchantSerializer.new(merchant).serialized_json
  end

  def index
    merchants = Merchant.search_all(query_params)
    render json: MerchantSerializer.new(merchants).serialized_json
  end
end
