Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :users, only: %i[edit update show] do
    member do
      get 'bookmark'
      get 'following'
    end
    resources :gifts, only: %i[index new create]
    resources :profiles, only: %i[new create edit update]
  end
  resources :rooms, only: %i[new create] do
    collection do
      get 'search'
      get 'lets_gift'
    end
  end
  resources :messages, only: %i[index create]

  resources :relationships, only: %i[create destroy]

  resources :testsessions, only: :create
end
