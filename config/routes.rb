Rails.application.routes.draw do
  root "home#index"
  # resources :applicants, only: [:create, :update, :show, :new]
  # resources :funnels, only: [:index]
end
