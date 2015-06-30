Rails.application.routes.draw do
  root "home#index"

  get "shoppers/apply" => "applicants#new", as: :new_applicant

  resources :applicants, only: %i(create), path: "shoppers" do
    collection do
      get :background
      post :background_authorize
      get :confirmation
    end
  end

  # resources :funnels, only: [:index]
end
