Rails.application.routes.draw do

  devise_for :users
  root 'events#index'

  resources :events do
    scope module: :events do
      resources :attends, only: [:new, :create, :destroy]
      resources :favorites, only: [:create, :destroy]
      resources :details_images, only: [:create, :destroy]
    end
  end

  resources :users, only: [:show, :edit, :update]

  namespace :users do
    resources :mylists, only: [:show]
  end

  post 'search', to: 'search#index'
  get 'search', to: 'search#index'

  resources :places, only: [:index]

  post 'line_callback', to: "line#callback"

end
