Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      get '/revenue', to: 'biz_int#revenue_over_time'

      namespace :items do
        get '/:id/merchant', to: 'merchants#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/:id/revenue', to: 'biz_int#merchant_revenue'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'biz_int#most_revenue'
        get '/most_items', to: 'biz_int#most_items'
      end

      resources :items, only: [:show, :index, :create, :update, :destroy]
      resources :merchants, only: [:show, :index, :create, :update, :destroy]

    end
  end
end
