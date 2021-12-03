require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  get "welcome/index"
  root to: "welcome#index"
  resources :users
  resources :grades do
    collection do
      post :add_teachers
      post :subscribe_student
      get :unsubscribe_student
    end
    member do
      get :inscription_teachers
      get :inscription_students
    end
  end

  resources :autocomplete, only: :none do
    collection do
      get :students
    end
  end
end
