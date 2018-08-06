Rails.application.routes.draw do
  get 'tags/:name', to: "thoughts#by_tag", as: "by_tag"
  resources :thoughts
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
