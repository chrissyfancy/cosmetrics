Rails.application.routes.draw do
    root "products#index"
  devise_for :users

  resources :products do
    resources :reviews
  end

  namespace :admin do
    resources :users
  end

  resources :reviews do
    post 'upvote'
    post 'downvote'
  end
end
