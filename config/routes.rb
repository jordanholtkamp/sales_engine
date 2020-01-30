Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      get '/merchants/:merchant_id/items', to: 'merchant_items#index'
      
      resources :items, only: [:index, :show]
      
      resources :invoices, only: [:index, :show]

      resources :transactions, only: [:index, :show]
    end
  end
end
