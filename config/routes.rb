Rails.application.routes.draw do
  root "home#index"

  get "apply-now" => "applicants#new", as: :new_applicant

  resources :applicants

  # resources :funnels, only: [:index]
end
