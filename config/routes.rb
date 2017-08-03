Rails.application.routes.draw do
  root "products#index"

  namespace :admin do
    resources :users
  end

  namespace :api do
    namespace :v1 do
      resources :users
      resources :products do
        resources :reviews
      end
    end
  end

  devise_for :users
  resources :categories

  resources :products do
    resources :reviews
  end

  resources :reviews do
    post 'upvote'
    post 'downvote'
  end

end
