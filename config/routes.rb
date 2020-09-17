Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :users, only: [:edit, :update, :show] do
    resources :gifts, only: [:index, :new, :create]
  end
  resources :rooms, only: [:new, :create] do
    resources :messages, only: [:index, :create]
  end
end
