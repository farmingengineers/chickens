MattsChickens::Application.routes.draw do
  root to: 'home#index'
  resources :flocks do
    resources :feedings, :egg_collections
    resources :activities do
      collection do
        delete :destroy
      end
    end
  end
  resources :reports
  devise_for :users if $configure_devise
end
