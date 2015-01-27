Rails.application.routes.draw do
  scope "v1" do
    resources :birthdays, only: :index
  end
end
