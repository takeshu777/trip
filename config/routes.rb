Rails.application.routes.draw do

  devise_for :users
  root 'events#index'

  resources :events do
  end

  resources :users, only: [:show, :edit, :update]

end
