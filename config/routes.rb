Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :forecast, only: [:show]
      resource :backgrounds, only: [:show]
      resource :users, only: [:create]
      resource :sessions, only: [:create]
      post '/road_trip', to: 'road_trip#create'
      get '/salaries', to: 'salaries#index'
    end
  end
end
