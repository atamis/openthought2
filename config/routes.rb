Rails.application.routes.draw do
  resources :thoughts
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
