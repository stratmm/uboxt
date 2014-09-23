Rails.application.routes.draw do
  root 'static_pages#home'

  namespace :api do
    resources :github_users, only: [:show]
  end

end
