Rails.application.routes.draw do
  devise_for :users
  root to: "messages#index"
  resources :rooms, only: [:new, :create]
end
