Rails.application.routes.draw do
  devise_for :users
  root to: 'messages#index'
  resources :users, only: %i[edit update]
  resources :rooms, only: %i[new create]
end
