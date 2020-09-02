Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:show, :index]
      resources :merchants, only: [:show, :index]
    end
  end
end
