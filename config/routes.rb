Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get :profile, to: "pages#profile"

  resources :projects, only: [:new, :create, :show, :update, :index] do
    collection do
      get :current_project
    end
    resources :project_companies, only: [:new, :create] do
      resources :reviews, only: [:index, :new, :create]
    end
    resources :companies, only: [:index, :show]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
