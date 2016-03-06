Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'home#index'

  resources :albums, :show
  resources :artists, :index

  scope WeeklyAnniversaries::API_VERSION do
    resources :anniversaries, only: :index
    resources :albums, only: [:index, :show]
    resources :artists, only: [:index, :update]
  end
end
