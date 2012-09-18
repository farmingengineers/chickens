MattsChickens::Application.routes.draw do
  root :to => 'home#index'
  resources :flocks
  devise_for :users
end
