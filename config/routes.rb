Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  # Defines the root path route ("/")
  root "users#index"

  resources :users, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
      # Paginate post with kaminari
      get '/page/:page', action: :index, on: :collection
    end
  end
end
