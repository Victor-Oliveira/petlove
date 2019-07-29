Rails.application.routes.draw do
  get 'home/index'

  resources :people do
    resources :animals
  end

  resources :animal_types

  root to: 'home#index'
end
