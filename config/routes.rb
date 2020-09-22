Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :users, only: %i[edit update show] do
    member do
      get 'bookmark'
    end
    resources :gifts, only: %i[index new create]
    resources :profiles, only: [:new, :create]
  end
  resources :rooms, only: %i[new create] do
    collection do
      get 'search'
      get 'lets_gift'
    end
    resources :messages, only: %i[index create]
  end

  resources :relationships, only: %i[create destroy]
end
