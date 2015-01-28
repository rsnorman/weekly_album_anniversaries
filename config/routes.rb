Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'home#index'

  scope "v1" do
    resources :birthdays, only: :index
  end
end
