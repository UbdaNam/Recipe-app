Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'

  get 'welcome', to: 'welcome#index', as: :welcome
  get 'foods', to: 'foods#index', as: :foods
  get 'foods/new', to: 'foods#new', as: :new_food
  post '/foods', to: 'foods#create'
end
