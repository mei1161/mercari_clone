Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "items#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }
  resources :users, only: [:show]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  scope :user do
    resources :point_histories
    resources :drafts, only: %i[index show]
  end

  scope :point do
    resource :purchase
  end

  resources :likes, only: %i[create destroy]
  resources :items, only: %i[index show create destroy edit new update] do
    member do
      post :buy
    end
    resources :comments, only: %i[create destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
