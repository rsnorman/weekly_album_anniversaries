Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'home#index'

  resources :albums, :show  

  scope WeeklyAnniversaries::API_VERSION do
    resources :anniversaries, only: :index
    resources :albums, only: [:index, :show]
  end
end
