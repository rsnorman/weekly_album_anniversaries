Rails.application.routes.draw do
  root 'home#index'

  scope "v1" do
    resources :birthdays, only: :index
  end
end
