Rails.application.routes.draw do
  get 'public_recipes/index'
  get 'recipe_foods/index'
  get 'recipe_foods/show'
  get 'recipe_foods/new'
  get 'recipe_foods/create'
  get 'recipe_foods/destroy'
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'

  get 'welcome/index', to: 'welcome#index', as: :welcome
  patch 'recipes/:id/update_public', to: 'recipes#update_public', as: 'recipe_update_public'

  resources :foods

  resources :recipes, only: %i[index show new create destroy] do
    patch :update_public, on: :member
  end

  resources :recipes do
    resources :shopping_lists, only: [:index]
  end

  resources :shopping_lists, only: [:index]
  resources :public_recipes, only: [:index]
  resources :recipe_foods, only: %i[create new destroy], path: 'recipe_foods'

end
