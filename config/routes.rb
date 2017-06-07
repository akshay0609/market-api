require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
  devise_for :users
	  namespace :api do
                              # constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, :only => [:show, :create, :update, :destroy] do 
        resources :products, :only => [:create, :update, :destroy]
        resources :orders, :only => [:index, :show, :create] 
      end
      resources :products, :only => [:index, :show]
      resources :sessions, :only => [:create, :destroy]
    end
  end
end