Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # get 'boards', to: "boards#index"
  # post 'boards', to: "boards#create"
  # post 'boards/new', to: "boards#create"
  # get 'boards/new', to: "boards#new"
  # post 'boards/new', to: "boards#new"
  resources :boards  do
    member do
      patch :toggle
    end
  end
  root 'boards#index'
  post 'boards/:id/edit' => 'boards#edit'
  post 'boards/:id' => 'boards#destroy'

 

end
