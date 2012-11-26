MattsChickens::Application.routes.draw do
  root to: 'home#index'
  resources :flocks do
    resources :feedings, :egg_collections
  end
  resources :reports
  devise_for :users if $configure_devise
end
