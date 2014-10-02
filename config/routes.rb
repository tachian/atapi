require 'api_constraints'

Atapi::Application.routes.draw do

  scope module: 'api', defaults: {format: :json}, constraints: {format: :json} do
  # scope module: 'api' do
    # API Version 1
    constraints ApiConstraints.new(1) do
      scope module: 'v1' do

        resources :universities do
          resources :courses
        end

        resources :subjects do
          member do
            get 'courses', :to => "courses#index"
          end
        end


        resources :courses do
          resources :lectures
          resources :visits
        end

        resources :lectures do
          resources :parts
          resources :visits
        end

        resources :parts do
          resources :visits
        end

        resources :courses do
          resource :subjects
        end

        resources :users do
          resources :visits
        end

        resources :visits

        # Devise authentication
        devise_for :users, path: '', :skip => [:registrations, :confirmations], path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: {registrations: 'api/v1/registrations', sessions: 'api/v1/sessions', passwords: 'api/v1/passwords', confirmations: 'api/v1/confirmations'}
        devise_scope :user do
          post '/facebook/login', to: 'authentications#create'
          post '/register', to: 'registrations#create'
          post '/login', to: 'sessions#create'
          # delete '/logout', to: 'sessions#destroy'
          get '/registration', to: 'registrations#edit'
          put '/registration', to: 'registrations#update'
          post '/password', to: 'passwords#create'
          put '/password', to: 'passwords#update'
          post '/confirmation/resend', to: 'confirmations#resend'
          post '/confirmation', to: 'confirmations#confirm', as: :user_confirmation
          # Support
          post '/impersonate', to: 'authentications#impersonate'
        end


      end
    end
  end
end
