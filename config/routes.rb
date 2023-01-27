# frozen_string_literal: true

Rails.application.routes.draw do
  get '/session', to: 'session#show'
  post '/session', to: 'session#create'
  put '/session/:token', to: 'session#confirm', as: 'session_confirm'

  post '/login', to: 'login#create'

  post '/account', to: 'account#create'
  put '/account/:token', to: 'account#confirm', as: 'account_confirm'

  delete '/account', to: 'account#destroy'

  resources :jobs
end
