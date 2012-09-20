MattsChickens::Application.routes.draw do
  root :to => 'home#index'
  resources :flocks do
    resources :feedings, :collections
  end
  devise_for :users
end
