Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/api/v0/markets/search', to: 'api/v0/markets#search'
  get '/api/v0/markets/:id/nearest_atms', to: 'api/v0/markets#nearest_atms'

  get '/api/v0/vendors/multiple_states', to: 'api/v0/vendors#multiple_states'
  
  namespace :api do
    namespace :v0 do
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
      end
      resources :vendors, only: [:show, :create, :update, :destroy]
      resources :market_vendors, only: [:create]
    end
  end

  delete '/api/v0/market_vendors', to: 'api/v0/market_vendors#destroy'
end
