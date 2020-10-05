Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :users, only: %i[edit update show] do
    member do
      get 'bookmark'
      get 'following'
      get 'followers'
      get 'gift_history'
      post 'testgifting',to: 'gifts#test_gifting'
    end
    resources :gifts, only: %i[index new create]
    resources :profiles, only: %i[new create edit update]
  end
  resources :rooms, only: %i[new create] do
    collection do
      get 'search'
      get 'lets_gift'
    end

    post 'add' => 'likes#create'
    delete '/add' => 'likes#destroy'
  end
  resources :messages, only: %i[index create]

  resources :relationships, only: %i[create destroy]

  resources :testsessions, only: :create
end
