# frozen_string_literal: true

Rails.application.routes.draw do
  get '/session', to: 'session#show'
  post '/session', to: 'session#create'
  put '/session/:token', to: 'session#confirm', as: 'session_confirm'

  post '/login', to: 'login#create'

  post '/registration', to: 'registration#create'
  put '/registration/:token', to: 'registration#confirm', as: 'registration_confirm'

  delete '/account', to: 'account#destroy'

  resources :jobs
end
