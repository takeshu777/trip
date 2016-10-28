Rails.application.routes.draw do

  devise_for :users
  root 'events#index'

  resources :events do
  end

  namespace :users do
    resources :mylists, only: [:show]
  end


  resources :users, only: [:show, :edit, :update] do
  end

end
