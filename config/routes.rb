Rails.application.routes.draw do
  resources :albums
  devise_for :users
  root to: 'recipes#index'

  get 'search', to: 'recipes#search'

  resources :recipes, only: %i[index show new create edit update]
  resources :recipe_types, only: %i[show new create]
  resources :cuisines, only: %i[ show new create ]

  namespace :api do 
    namespace :v1 do
      resources :recipes, only: %i[show create]
      resources :recipe_types, only: %i[create]
    end
  end
  
end
