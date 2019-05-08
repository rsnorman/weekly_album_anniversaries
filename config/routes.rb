# frozen_string_literal: true

Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'home#index'

  resources :albums, only: :show

  scope WeeklyAnniversaries::API_VERSION do
    resources :anniversaries, only: :index
    resources :albums, only: %i[index show]

    namespace :admin do
      resources :artists, only: %i[index update]
      resources :albums, only: %i[index update]
      resources :scheduled_tweets, only: %i[index update]
    end
  end

  namespace :admin do
    resources :artists, only: :index
    resources :albums, only: :index
    resources :scheduled_tweets, only: :index
    get '/login', action: :login, controller: 'admin'
    post '/login', action: :login, controller: 'admin'
    get '/', action: :home, controller: 'admin'
  end
end
