Rails.application.routes.draw do

  devise_for :users
  root 'events#index'

  resources :events do
    scope module: :events do
      resources :attends, only: [:new, :create, :destroy]
    end
  end

  resources :users, only: [:show, :edit, :update]

  namespace :users do
    resources :mylists, only: [:show]
  end

end
