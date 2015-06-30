Rails.application.routes.draw do
  root "home#index"

  get "shoppers/apply" => "applicants#new", as: :new_applicant

  get "shoppers/login" => "sessions#new", as: :login
  post "shoppers/login" => "sessions#create"
  post "shoppers/logout" => "sessions#logout", as: :logout

  resources :applicants, only: %i(create edit update), path: "shoppers" do
    collection do
      get :background
      post :background_authorize, path: "authorize"
      get :confirmation
    end
  end

  # resources :funnels, only: [:index]
end
