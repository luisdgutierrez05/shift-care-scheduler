# frozen_string_literal: true

# == Route Map
#            Prefix Verb                 URI Pattern                            Controller#Action
#                new_user_session GET    /users/sign_in(.:format)               devise/sessions#new
#                    user_session POST   /users/sign_in(.:format)               devise/sessions#create
#            destroy_user_session DELETE /users/sign_out(.:format)              devise/sessions#destroy
#               new_user_password GET    /users/password/new(.:format)          devise/passwords#new
#              edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
#                   user_password PATCH  /users/password(.:format)              devise/passwords#update
#                                 PUT    /users/password(.:format)              devise/passwords#update
#                                 POST   /users/password(.:format)              devise/passwords#create
#                            root GET    /                                      devise/sessions#new
#           admin_dashboard_index GET    /admin/dashboard(.:format)             admin/dashboard#index
#                   admin_clients GET    /admin/clients(.:format)               admin/clients#index
#                                 POST   /admin/clients(.:format)               admin/clients#create
#                new_admin_client GET    /admin/clients/new(.:format)           admin/clients#new
#               edit_admin_client GET    /admin/clients/:id/edit(.:format)      admin/clients#edit
#                    admin_client GET    /admin/clients/:id(.:format)           admin/clients#show
#                                 PATCH  /admin/clients/:id(.:format)           admin/clients#update
#                                 PUT    /admin/clients/:id(.:format)           admin/clients#update
#                                 DELETE /admin/clients/:id(.:format)           admin/clients#destroy
#                  admin_plumbers GET    /admin/plumbers(.:format)              admin/plumbers#index
#                                 POST   /admin/plumbers(.:format)              admin/plumbers#create
#               new_admin_plumber GET    /admin/plumbers/new(.:format)          admin/plumbers#new
#              edit_admin_plumber GET    /admin/plumbers/:id/edit(.:format)     admin/plumbers#edit
#                   admin_plumber GET    /admin/plumbers/:id(.:format)          admin/plumbers#show
#                                 PATCH  /admin/plumbers/:id(.:format)          admin/plumbers#update
#                                 PUT    /admin/plumbers/:id(.:format)          admin/plumbers#update
#                                 DELETE /admin/plumbers/:id(.:format)          admin/plumbers#destroy
#                      admin_jobs POST   /admin/jobs(.:format)                  admin/jobs#create
#                   new_admin_job GET    /admin/jobs/new(.:format)              admin/jobs#new
#                     api_v1_jobs GET    /api/v1/jobs(.:format)                 api/v1/jobs#index {:format=>"json"}
#                      api_v1_job PATCH  /api/v1/jobs/:id(.:format)             api/v1/jobs#update {:format=>"json"}
#                                 PUT    /api/v1/jobs/:id(.:format)             api/v1/jobs#update {:format=>"json"}
#                          api_v1        /api/v1/*path(.:format)                api/v1/api#routing_error {:format=>"json"}
# turbo_recede_historical_location GET    /recede_historical_location(.:format)  turbo/native/navigation#recede
# turbo_resume_historical_location GET    /resume_historical_location(.:format)  turbo/native/navigation#resume
# turbo_refresh_historical_location GET    /refresh_historical_location(.:format) turbo/native/navigation#refresh

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
