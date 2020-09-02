Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:show, :index]
      resources :merchants, only: [:show, :index]

      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end

      namespace :items do
        get '/:id/merchant', to: 'merchants#index'
      end
    end
  end
end
