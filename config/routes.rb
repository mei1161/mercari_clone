Rails.application.routes.draw do
  root "users#show"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
