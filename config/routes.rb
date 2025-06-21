Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users
  resources :tickets

  mount GoodJob::Engine, at: "good_job"
end
