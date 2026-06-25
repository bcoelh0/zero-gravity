Rails.application.routes.draw do
  root "welcome#index"

  get "/t/dash",   to: "teacher_dashboard#index",  as: :teacher_dashboard
  get "/hod/dash", to: "hod_dashboard#index",       as: :hod_dashboard

  get "/strategy", to: "pages#strategy", as: :strategy

  resources :task_completions, only: [:create, :destroy]
  resources :tasks, only: [:show]
  get "/demo/switch", to: "demo_sessions#create", as: :demo_switch

  get "up" => "rails/health#show", as: :rails_health_check
end
