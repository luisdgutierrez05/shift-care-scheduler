# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root 'devise/sessions#new'
  end

  namespace :admin do
    resources :dashboard, only: %i[index]
    resources :clients
    resources :plumbers
    resources :jobs, only: %i[new create]
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :jobs, only: %i[index update]

      match '*path', to: 'api#routing_error', via: :all
    end
  end
end
