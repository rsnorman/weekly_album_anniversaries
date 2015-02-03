Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'home#index'

  scope WeeklyAnniversaries::API_VERSION do
    resources :anniversaries, only: :index
  end
end
