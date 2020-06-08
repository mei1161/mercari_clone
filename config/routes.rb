Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "users#show"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }
  resources :users, only: [:show]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
