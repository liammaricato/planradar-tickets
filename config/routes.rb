Rails.application.routes.draw do
  root "tickets#index"

  resources :users
  resources :tickets

  mount GoodJob::Engine, at: "good_job"
end
