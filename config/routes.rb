Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :users, only: %i[edit update show] do
    member do
      get 'following'
      get 'followers'
      get 'gift_history'
      post 'testgifting', to: 'gifts#test_gifting'
    end
    resources :gifts, only: %i[index new create]
    resources :profiles, only: %i[new create edit update]
    resources :bookmarks, only: %i[index new create destroy]
  end
  resources :rooms, only: %i[new create destroy] do
    collection do
      get 'search'
    end

    post 'add' => 'likes#create'
    delete '/add' => 'likes#destroy'
  end
  resources :messages, only: %i[index create]
  resources :relationships, only: %i[create destroy]
  resources :testsessions, only: :create
  resources :notifications, only: :index
  resources :game_tags, only: %i[] do
    member do
      get 'tag_search'
    end
  end
end
