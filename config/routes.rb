Rails.application.routes.draw do

  root 'events#index'

  resources :events do
  end

end
