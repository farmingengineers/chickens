MattsChickens::Application.routes.draw do
  root 'home#index'
  get 'information' => redirect('/feed_types')
  resources :feed_types
  resources :flocks do
    resources :feedings, :egg_collections
  end
  resources :reports
  devise_for :users
end
