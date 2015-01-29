Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'home#index'

  scope WeeklyBirthdays::API_VERSION do
    resources :birthdays, only: :index
  end
end
