Rails.application.routes.draw do
  root "products#index"

  namespace :admin do
    resources :users
  end

  namespace :api do
    namespace :v1 do
      resources :users
      resources :products do
        resources :reviews do
          resources :users do
            resources :votes
          end
        end
      end
    end
  end

  devise_for :users
  resources :categories
  resources :products
end
