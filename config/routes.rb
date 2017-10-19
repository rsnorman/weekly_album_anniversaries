Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'home#index'

  resources :albums, only: :show

  scope WeeklyAnniversaries::API_VERSION do
    resources :anniversaries, only: :index
    resources :albums, only: [:index, :show]

    namespace :admin do
      resources :artists, only: [:index, :update]
      resources :albums, only: [:index, :update]
      resources :scheduled_tweets, only: [:index, :update]
    end
  end

  namespace :admin do
    resources :artists, only: :index
    resources :albums, only: :index
    resources :scheduled_tweets, only: :index
    get '/login', to: :login, controller: 'admin'
    post '/login', to: :login, controller: 'admin'
    get '/', to: :home, controller: 'admin'
  end
end
