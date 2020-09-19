Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :users, only: [:edit, :update, :show] do
    member do
      get 'bookmark'
    end
    resources :gifts, only: [:index, :new, :create]
  end
  resources :rooms, only: [:new, :create] do
    collection do
      get 'search'
    end
    resources :messages, only: [:index, :create]
  end
end
