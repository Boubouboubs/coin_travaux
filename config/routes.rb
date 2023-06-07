Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :projects, only: [:create, :show, :update] do
    resources :project_companies, only: [:create]
    resources :compagnies, only: [:index]
  end

  resources :companies, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
