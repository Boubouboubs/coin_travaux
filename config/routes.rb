Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :projects, only: [:new, :create, :show, :update] do
    resources :project_companies, only: [:new, :create] do
      resources :reviews, only: [:index, :new, :create]
    end
    resources :companies, only: [:index, :show]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
