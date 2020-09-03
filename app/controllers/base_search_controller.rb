class BaseSearchController < ApplicationController
  def query_params
    query_key = params.keys.reject do |key|
      %w(controller action).include?(key)
    end.first
    { query_key.to_sym => params[query_key] }
  end
end
